import 'dart:io';
import 'package:flutter_single_instance/flutter_single_instance.dart';

/// Implementation of [FlutterSingleInstance] for Windows.
class Windows extends FlutterSingleInstance {
  /// Implementation of [FlutterSingleInstance] for Windows.
  Windows() : super.internal();

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

    // No process found when there are less than 3 rows
    // if the process is found, there are exactly 3 rows
    if (output.split("\n").length != 3) {
      return null;
    } else {
      output = output.split("\n").last;

      var parts = output.split(" ");

      return parts.first.replaceAll(".exe", "");
    }
  }
}
