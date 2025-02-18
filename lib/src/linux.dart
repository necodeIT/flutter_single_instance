import 'dart:io';
import 'package:flutter_single_instance/flutter_single_instance.dart';

/// Implementation of [FlutterSingleInstance] for Linux.
class Linux extends FlutterSingleInstance {
  /// Implementation of [FlutterSingleInstance] for Linux.
  Linux() : super.internal();

  @override
  Future<String?> getProcessName(pid) async {
    var result = await Process.run("ps", ["-p", "$pid"]);

    // should be something like:
    // ```
    //     PID TTY          TIME CMD
    //  xxxxx ?        xx:xx:xx process_name
    // ```
    // or emtpy if process does not exist
    var output = result.stdout.toString().trim();

    if (output.isEmpty) {
      return null;
    } else {
      output = output.split("\n").last;

      var parts = output.split(" ");

      return parts.last;
    }
  }

  @override
  Future<File?> getPidFile(String processName) async {
    return File('/tmp/$processName.pid');
  }
}
