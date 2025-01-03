import 'dart:io';
import 'package:flutter_single_instance/flutter_single_instance.dart';

/// Provides utilities for checking if this is the first instance of the app.
///
/// Platform-specific implementation for Windows.
class FlutterSingleInstanceWindows extends FlutterSingleInstance {
  const FlutterSingleInstanceWindows() : super.internal();

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
