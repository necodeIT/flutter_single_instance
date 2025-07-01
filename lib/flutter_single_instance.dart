/// A simple way to check if your application is already running.
///
/// ---
///
/// ```dart
/// import 'dart:io';
///
/// import 'package:flutter/material.dart';
/// import 'package:flutter_single_instance/flutter_single_instance.dart';
///
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await windowManager.ensureInitialized();
///
///   if (await FlutterSingleInstance().isFirstInstance()) {
///     runApp(const MyApp());
///   } else {
///     print("App is already running");
///
///     final err = await FlutterSingleInstance().focus();
///
///     if (err != null) {
///       print("Error focusing running instance: $err");
///     }
///
///     exit(0);
///   }
/// }
/// ```
library flutter_single_instance;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_single_instance/src/focus.dart';
import 'package:flutter_single_instance/src/generated/focus.pbgrpc.dart';
import 'package:flutter_single_instance/src/instance.dart';
import 'package:grpc/grpc.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

import 'src/linux.dart';
import 'src/macos.dart';
import 'src/unsupported.dart';
import 'src/windows.dart';

export 'package:window_manager/window_manager.dart' show windowManager;

/// Provides utilities for checking if this is the first instance of the app.
/// Make sure to call `WidgetsFlutterBinding.ensureInitialized()` before using this class.
abstract class FlutterSingleInstance {
  static FlutterSingleInstance? _singelton;

  /// Internal constructor for implementations.
  @protected
  FlutterSingleInstance.internal();

  /// The port used for the RPC server receiving focus requests.
  ///
  /// Defaults to `0`, letting the OS choose a random port.
  static int port = 0;

  /// The address used for the RPC server receiving focus requests.
  ///
  /// Defaults to `InternetAddress.loopbackIPv4`.
  static dynamic address = InternetAddress.loopbackIPv4;

  /// The process name used to verify the process saved in the pid file.
  ///
  /// If not set [getProcessName] will be used with the current [pid].
  static String? processName;

  Server? _server;
  Instance? _instance;
  bool? _isFirstInstance;
  RandomAccessFile? _locker;

  /// Logger for this class.
  @protected
  Logger get logger => Logger('FlutterSingleInstance.$runtimeType');

  /// Provides utilities for checking if this is the first instance of the app.
  /// Make sure to call `WidgetsFlutterBinding.ensureInitialized()` before using this class.
  factory FlutterSingleInstance() {
    _singelton ??= kIsWeb
        ? Unsupported()
        : Platform.isMacOS
            ? MacOS()
            : Platform.isLinux
                ? Linux()
                : Platform.isWindows
                    ? Windows()
                    : Unsupported();

    return _singelton!;
  }

  /// If enabled [FlutterSingleInstance.isFirstInstance] will always return true.
  /// Defaults to [kDebugMode].
  static bool debugMode = kDebugMode;

  /// Called before this instance is focused with metadata provided by the calling instance.
  ///
  /// ```dart
  /// FlutterSingleInstance.onFocus = (metadata) {
  ///   print("Focused instance with metadata: $metadata"); // "Focused instance with metadata: {hello: world}"
  /// };
  ///
  /// FlutterSingleInstance().focus({"hello": "world"});
  /// ```
  static FutureOr<void> Function(Map<String, dynamic>)? onFocus;

  /// Retrieves the process name of the given [pid].
  /// Returns [null] if the process does not exist.
  Future<String?> getProcessName(int pid);

  /// Returns true if this is the first instance of the app.
  /// Automatically writes a pid file to the temp directory if this is the first instance.
  Future<bool> isFirstInstance() async {
    _isFirstInstance ??= await () async {
      if (debugMode) {
        logger.finest("Debug mode enabled, reporting as first instance");
        return true;
      }

      var processName = FlutterSingleInstance.processName ??
          await getProcessName(pid); // get name of current process
      processName!;

      return activateInstance(processName);
    }();

    return _isFirstInstance!;
  }

  /// Activates the first instance of the app and writes a pid file to the temp directory.
  @protected
  Future<bool> activateInstance(String processName) async {
    assert(_locker == null && _instance == null,
        "activateInstance should only be called once");

    final pidFile = await getPidFile(processName);
    if (pidFile == null) {
      logger.finest("Failed to get pid file, assuming first instance");
      return true;
    }

    // Try to lock the file, if it fails, another instance is running
    try {
      final locker =
          await File(pidFile.path + ".lock").open(mode: FileMode.write);
      _locker = await locker.lock();
    } catch (_) {}

    if (_locker == null) {
      // Another instance is running, try to read the pid file
      try {
        final data = await pidFile.readAsString();
        final json = jsonDecode(data);

        _instance = Instance.fromJson(json);

        logger.finest("Failed to lock pid file, reporting as second instance");
      } catch (e, s) {
        logger.finest(
            "Pid file is wrong format, reporting as second instance", e, s);
      }

      return false;
    } else {
      // This is the first instance, create a new instance and write it to the pid file
      final instance = Instance(
        pid: pid,
        port: await startRpcServer(),
      );

      // Write the instance to the pid file
      await pidFile.writeAsString(jsonEncode(instance.toJson()));

      logger.finest("Activated $instance at ${pidFile.path}");
      return true;
    }
  }

  /// Returns the pid file.
  /// Does not check if file exists.
  Future<File?> getPidFile(String processName) async {
    var tmp = await getTemporaryDirectory();

    return File('${tmp.path}/$processName.pid');
  }

  /// Starts an RPC server that listens for focus requests.
  @protected
  Future<int> startRpcServer() async {
    if (_server != null) {
      logger.finest("RPC server already started");
      return _server!.port!;
    }

    logger.finest("Starting RPC server");

    _server = Server.create(
      services: [FocusService()],
      codecRegistry: CodecRegistry(
        codecs: const [
          GzipCodec(),
          IdentityCodec(),
        ],
      ),
    );

    await _server!.serve(port: port, address: address);

    logger.finest("RPC server started on port ${_server!.port}");

    return _server!.port!;
  }

  /// Focuses the running instance of the app and returns `null` if the operation was successful or an error message if it failed.
  ///
  /// The [metadata] parameter is passed to the focused instance's [onFocus] callback.
  /// If [bringToFront] is true, the focused instance will be brought to the front.
  Future<String?> focus([Object? metadata, bool bringToFront = true]) async {
    if (_instance == null) return "No instance to focus";
    if (_server != null) return "This is the first instance";

    logger.finest("Focusing instance: $_instance");

    try {
      final channel = ClientChannel(
        'localhost',
        port: _instance!.port,
        options: ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          codecRegistry: CodecRegistry(
            codecs: const [
              GzipCodec(),
              IdentityCodec(),
            ],
          ),
        ),
      );

      if (metadata == null) {
        metadata = <String, dynamic>{};
      }
      final json = jsonEncode(metadata);
      final binary = utf8.encode(json);

      final client = FocusServiceClient(channel);

      final response = await client
          .focus(FocusRequest(metadata: binary, bringToFront: bringToFront));

      if (response.success) {
        logger.finest("Instance focused");

        return null;
      } else {
        logger.finest('Failed to focus instance', response.error);

        return response.error;
      }
    } catch (e) {
      logger.finest('Failed to focus instance', e);
      return e.toString();
    }
  }
}
