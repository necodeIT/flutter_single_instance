library flutter_single_instance;

import 'dart:io';

import 'src/flutter_single_instance.dart';
import 'src/flutter_single_instance_linux.dart';
import 'src/flutter_single_instance_macos.dart';
import 'src/flutter_single_instance_windows.dart';

/// Enforces single instance of the app.
///
/// Make sure to call `WidgetsFlutterBinding.ensureInitialized()` before using this class.
class FlutterSingleInstancePlatform {
  static FlutterSingleInstance? _instance;

  static FlutterSingleInstance get instance {
    _instance ??= Platform.isMacOS
        ? FlutterSingleInstanceMacOS()
        : Platform.isLinux
            ? FlutterSingleInstanceLinux()
            : Platform.isWindows
                ? FlutterSingleInstanceWindows()
                : throw UnsupportedError('Platform ${Platform.operatingSystem} is not supported.');

    return _instance!;
  }
  
  /// If enabled (default to [kDebugMode]) skips the check for the first instance.
  static get bool debugMode => FlutterSingleInstance.debugMode;
  
  static set bool debugMode(bool value){
    FlutterSingleInstance.debugMode = value;
  }
}
