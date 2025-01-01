/// Provides utilities for handiling single instancing in Flutter.
///
/// A simple usage example:
///
/// ```dart
/// import 'package:flutter_single_instance/flutter_single_instance.dart';
///
/// main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///
///   if(await FlutterSingleInstance().isFirstInstance()){
///     runApp(MyApp());
///   }else{
///     print("App is already running");
///
///     exit(0);
///   }
/// }
/// ```
library flutter_single_instance;

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'src/linux.dart';
import 'src/macos.dart';
import 'src/windows.dart';
import 'src/unsupported.dart';

/// Provides utilities for checking if this is the first instance of the app.
/// Make sure to call `WidgetsFlutterBinding.ensureInitialized()` before using this class.
abstract class FlutterSingleInstance {
  static FlutterSingleInstance? _instance;

  @protected
  const FlutterSingleInstance.internal();

  factory FlutterSingleInstance() {
    _instance ??= kIsWeb || Platform.isAndroid || Platform.isIOS
        ? const FlutterSingleInstanceUnsopported()
        : Platform.isMacOS
            ? const FlutterSingleInstanceMacOS()
            : Platform.isLinux
                ? const FlutterSingleInstanceLinux()
                : Platform.isWindows
                    ? const FlutterSingleInstanceWindows()
                    : throw UnsupportedError(
                        'Platform ${Platform.operatingSystem} is not supported.');

    return _instance!;
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
      return true;
    }

    var processName = await getProcessName(pid); // get name of current process
    processName!;

    var pidFile = await getPidFile(processName);
    pidFile!;

    if (pidFile.existsSync()) {
      var pid = int.parse(pidFile.readAsStringSync());

      var pidName = await getProcessName(pid);

      if (processName != pidName) {
        // Process does not exist, so we can activate this instance.
        await _activateInstance(processName);

        return true;
      } else {
        // Process exists, so this is not the first instance.
        return false;
      }
    } else {
      // No pid file, so this is the first instance.
      await _activateInstance(processName);

      return true;
    }
  }

  /// Activates the first instance of the app.
  /// Writes a pid file to the temp directory.
  Future<void> _activateInstance(String processName) async {
    var pidFile = await getPidFile(processName);

    await pidFile?.writeAsString('$pid');
  }

  /// Returns the pid file.
  /// Does not check if file exists.
  Future<File?> getPidFile(String processName) async {
    var tmp = await getTemporaryDirectory();

    return File('${tmp.path}/$processName.pid');
  }
}
