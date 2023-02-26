/// Provides utilities for handiling single instancing in Flutter.
///
/// A simple usage example:
///
/// ```dart
/// import 'package:flutter_single_instance/flutter_single_instance.dart';
///
/// main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///
///   if(await FlutterSingleInstance.platform.isFirstInstance()){
///     runApp(MyApp());
///   }else{
///     print("App is already running");
///
///     exit(0);
///   }
/// }
/// ```
library flutter_single_instance;

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'src/flutter_single_instance_linux.dart';
import 'src/flutter_single_instance_macos.dart';
import 'src/flutter_single_instance_windows.dart';

part 'flutter_single_instance_base.dart';

/// Provides utilities for checking if this is the first instance of the app.
/// Make sure to call `WidgetsFlutterBinding.ensureInitialized()` before using this class.
class FlutterSingleInstance {
  static FlutterSingleInstanceBase? _platform;

  /// The instance of [FlutterSingleInstanceBase] for the current platform.
  static FlutterSingleInstanceBase get platform {
    _platform ??= Platform.isMacOS
        ? FlutterSingleInstanceMacOS()
        : Platform.isLinux
            ? FlutterSingleInstanceLinux()
            : Platform.isWindows
                ? FlutterSingleInstanceWindows()
                : throw UnsupportedError('Platform ${Platform.operatingSystem} is not supported.');

    return _platform!;
  }

  /// If enabled [FlutterSingleInstanceBase.isFirstInstance] will always return true.
  /// Defaults to [kDebugMode].
  static bool debugMode = kDebugMode;
}
