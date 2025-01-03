import 'dart:io';
import 'package:flutter_single_instance/flutter_single_instance.dart';

/// Provides utilities for checking if this is the first instance of the app.
///
/// Platform-specific implementation for Linux.
class FlutterSingleInstanceLinux extends FlutterSingleInstance {
  const FlutterSingleInstanceLinux() : super.internal();

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
}
