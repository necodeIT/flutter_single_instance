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
