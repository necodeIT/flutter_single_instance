part of flutter_single_instance;

/// Base class for platform-specific implementations.
abstract class FlutterSingleInstanceBase {
  /// Retrieves the process name of the given [pid].
  /// Returns [null] if the process does not exist.
  Future<String?> getProcessName(int pid);

  /// Returns the pid file.
  /// Does not check if file exists.
  Future<File> getPidFile(String processName) async {
    var tmp = await getTemporaryDirectory();

    return File('${tmp.path}/$processName.pid');
  }

  /// Returns true if this is the first instance of the app.
  /// Automatically writes a pid file to the temp directory if this is the first instance.
  Future<bool> isFirstInstance() async {
    if (FlutterSingleInstance.debugMode) {
      return true;
    }

    var processName = await getProcessName(pid); // get name of current process
    processName!;

    var pidFile = await getPidFile(processName);

    if (pidFile.existsSync()) {
      var pid = int.parse(pidFile.readAsStringSync());

      var pidName = await getProcessName(pid);

      if (processName != pidName) {
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
  /// Writes a pid file to the temp directory.
  Future<void> _activateFirstInstance(String processName) async {
    var pidFile = await getPidFile(processName);

    await pidFile.writeAsString('$pid');
  }
}
