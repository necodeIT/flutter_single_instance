# Flutter Single Instance

Provides utilities for handiling single instancing in Flutter.

## Usage

A simple usage example:

```dart
import 'package:flutter_single_instance/flutter_single_instance.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if(await FlutterSingleInstance.platform.isFirstInstance()){
    runApp(MyApp());
  }else{
    print("App is already running");

    exit(0);
  }
}
```
