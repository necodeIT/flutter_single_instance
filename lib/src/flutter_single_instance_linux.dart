import 'dart:io';

import 'flutter_single_instance.dart';

class FlutterSingleInstanceLinux extends FlutterSingleInstance {
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
