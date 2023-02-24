import 'dart:io';

import 'flutter_single_instance.dart';

class FlutterSingleInstanceWindows extends FlutterSingleInstance {
  @override
  Future<String?> getProcessName(pid) async {
    var result = await Process.run("tasklist", ["/fi", "PID eq $pid"]);

    // should be something like:
    // ```
    // Image Name                     PID Session Name        Session#    Mem Usage
    // ========================= ======== ================ =========== ============
    // process_name.exe               xxx xx                    x      xxx xxx x
    // ```
    var output = result.stdout.toString().trim();

    if (output.isEmpty) {
      return null;
    } else {
      output = output.split("\n").last;

      var parts = output.split(" ");

      return parts.first.replaceAll(".exe", "");
    }
  }

  @override
  Future<void> activateFirstInstance(appName) {
    throw UnimplementedError();
  }
}
