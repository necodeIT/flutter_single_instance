# Flutter Single Instance

Provides utilities for handiling single instancing in Flutter.

| Platform | Support |
| -------- | ------- |
| Android  | ⚠️      |
| iOS      | ⚠️      |
| Web      | ⚠️      |
| macOS    | ✅      |
| Windows  | ✅      |
| Linux    | ✅      |

✅ - Confirmed working. <br/>
⚠️ - Always reports as first instance.

## Installation

Add `flutter_single_instance` as a dependency in your `pubspec.yaml` file.

```yaml
flutter pub add flutter_single_instance
```

### MacOS

Disable sandboxing in `macos/Runner/DebugProfile.entitlements` and `macos/Runner/Release.entitlements` files.

```xml
<key>com.apple.security.app-sandbox</key>
<false/>
```

## Usage

A simple usage example:

```dart
import 'package:flutter_single_instance/flutter_single_instance.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if(await FlutterSingleInstance().isFirstInstance()){
    runApp(MyApp());
  }else{
    print("App is already running");

    exit(0);
  }
}
```

## Web and other unsupported platforms

You can safely use this package in web and other unsupported platforms. It will always return `true` for `isFirstInstance` method.

## Limitations

Currently this package does not provide a way to bring the existing instance to the front. If you have any ideas on how to achieve this, please open an issue or a pull request.
