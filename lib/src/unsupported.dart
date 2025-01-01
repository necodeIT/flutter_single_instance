import 'dart:io';

import 'package:flutter_single_instance/flutter_single_instance.dart';

class FlutterSingleInstanceUnsopported extends FlutterSingleInstance {
  const FlutterSingleInstanceUnsopported() : super.internal();

  @override
  Future<String?> getProcessName(int pid) async => null;

  @override
  Future<bool> isFirstInstance() async => true;

  @override
  Future<File?> getPidFile(String processName) async => null;
}
