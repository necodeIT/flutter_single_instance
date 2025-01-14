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

export 'package:window_manager/window_manager.dart' show windowManager;

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
import 'src/windows.dart';
import 'src/unsupported.dart';

/// Provides utilities for checking if this is the first instance of the app.
/// Make sure to call `WidgetsFlutterBinding.ensureInitialized()` before using this class.
abstract class FlutterSingleInstance {
  static FlutterSingleInstance? _singelton;

  /// Internal constructor for implementations.
  @protected
  FlutterSingleInstance.internal();

  Server? _server;
  Instance? _instance;

  /// Logger for this class.
  @protected
  Logger get logger => Logger('FlutterSingleInstance.$runtimeType');

  /// Provides utilities for checking if this is the first instance of the app.
  /// Make sure to call `WidgetsFlutterBinding.ensureInitialized()` before using this class.
  factory FlutterSingleInstance() {
    _singelton ??= Platform.isMacOS
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

  /// Retrieves the process name of the given [pid].
  /// Returns [null] if the process does not exist.
  Future<String?> getProcessName(int pid);

  /// Returns true if this is the first instance of the app.
  /// Automatically writes a pid file to the temp directory if this is the first instance.
  Future<bool> isFirstInstance() async {
    if (debugMode) {
      logger.finest("Debug mode enabled, reporting as first instance");
      return true;
    }

    var processName = await getProcessName(pid); // get name of current process
    processName!;

    var pidFile = await getPidFile(processName);
    pidFile!;

    if (!pidFile.existsSync()) {
      logger.finest("No pid file found, activating instance");

      // No pid file, so this is the first instance.
      await activateInstance(processName);
      return true;
    }

    final data = await pidFile.readAsString();

    _instance = Instance.fromJson(jsonDecode(data));

    logger.finest("Pid file found, verifying instance: $_instance");

    final pidName = await getProcessName(_instance!.pid);

    if (processName == pidName) {
      logger.finest(
        "Process name matches $processName, reporting as second instance",
      );

      // Process exists, so this is not the first instance.
      return false;
    }

    logger.finest(
      "Process name does not match $processName, activating instance",
    );

    // Process does not exist, so we can activate this instance.
    await activateInstance(processName);

    return true;
  }

  /// Activates the first instance of the app and writes a pid file to the temp directory.
  @protected
  Future<void> activateInstance(String processName) async {
    var pidFile = await getPidFile(processName);

    if (pidFile?.existsSync() == false) await pidFile?.create();

    final instance = Instance(
      pid: pid,
      port: await startRpcServer(),
    );

    await pidFile?.writeAsString(jsonEncode(instance.toJson()));

    logger.finest("Activated $instance at ${pidFile?.path}");
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

    await _server!.serve(port: 0);

    logger.finest("RPC server started on port ${_server!.port}");

    return _server!.port!;
  }

  /// Focuses the running instance of the app and
  /// returns `null` if the operation was successful or an error message if it failed.
  Future<String?> focus() async {
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

      final client = FocusServiceClient(channel);

      final response = await client.focus(FocusRequest());

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
