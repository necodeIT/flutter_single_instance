import 'dart:io';

import 'package:flutter_single_instance/flutter_single_instance.dart';

/// Implementation of [FlutterSingleInstance] for unsupported platforms.
class FlutterSingleInstanceUnsopported extends FlutterSingleInstance {
  /// Implementation of [FlutterSingleInstance] for unsupported platforms.
  FlutterSingleInstanceUnsopported() : super.internal();

  @override
  Future<String?> getProcessName(int pid) async => null;

  @override
  Future<bool> isFirstInstance() async => true;

  @override
  Future<File?> getPidFile(String processName) async => null;

  @override
  Future<String?> focus() async => null;

  @override
  Future<void> activateInstance(String processName) async {}

  @override
  Future<int> startRpcServer() {
    throw UnsupportedError('startRpcServer is not supported on this platform');
  }
}
