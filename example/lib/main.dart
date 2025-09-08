import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_single_instance/flutter_single_instance.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  if (await FlutterSingleInstance().isFirstInstance()) {
    runApp(const MyApp());
  } else {
    print("App is already running");

    final err = await FlutterSingleInstance().focus();

    if (err != null) {
      print("Error focusing running instance: $err");
    }

    exit(0);
  }
}
