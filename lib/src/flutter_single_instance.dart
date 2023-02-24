import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

abstract class FlutterSingleInstance {
  /// Retrieves the process name of the given [pid].
  ///
  /// Returns null if the process does not exist.
  Future<String?> getProcessName(int pid);

  /// If enabled (default to [kDebugMode]) skips the check for the first instance.
  static bool debugMode = kDebugMode;

  /// Returns the pid file.
  ///
  /// Does not check if file exists.
  Future<File> _getPidFile(String processName) async {
    var tmp = await getTemporaryDirectory();

    return File('${tmp.path}/$processName.pid');
  }

  /// Returns true if this is the first instance of the app.
  ///
  /// Calls [activateFirstInstance] if this is the first instance.
  Future<bool> isFirstInstance(String processName) async {
    if (debugMode) {
      return true;
    }

    var pidFile = await _getPidFile(processName);

    if (pidFile.existsSync()) {
      var pid = int.parse(pidFile.readAsStringSync());

      var pidName = await getProcessName(pid);

      if (pidName == null) {
        // Process does not exist, so we can activate this instance.
        await _activateFirstInstance(processName);

        return true;
      } else {
        // Process exists, so this is not the first instance.
        return false;
      }
    } else {
      // No pid file, so this is the first instance.
      await _activateFirstInstance(processName);

      return true;
    }
  }

  /// Activates the first instance of the app.
  ///
  /// Writes a pid file to the temp directory.
  Future<void> _activateFirstInstance(String processName) async {
    var pidFile = await _getPidFile(processName);

    await pidFile.writeAsString('$pid');
  }
}
