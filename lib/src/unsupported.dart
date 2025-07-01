import 'dart:io';

import 'package:flutter_single_instance/flutter_single_instance.dart';

/// Implementation of [FlutterSingleInstance] for unsupported platforms.
class Unsupported extends FlutterSingleInstance {
  /// Implementation of [FlutterSingleInstance] for unsupported platforms.
  Unsupported() : super.internal();

  @override
  Future<String?> getProcessName(int pid) async => null;

  @override
  Future<bool> isFirstInstance() async => true;

  @override
  Future<File?> getPidFile(String processName) async => null;

  @override
  Future<String?> focus([Object? metadata, bool bringToFront = true]) async =>
      null;

  @override
  Future<bool> activateInstance(String processName) async => true;

  @override
  Future<int> startRpcServer() {
    throw UnsupportedError('startRpcServer is not supported on this platform');
  }
}
