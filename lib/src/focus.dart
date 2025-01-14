import 'package:flutter_single_instance/src/generated/focus.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:window_manager/window_manager.dart';

class FocusService extends FocusServiceBase {
  @override
  Future<FocusResponse> focus(ServiceCall call, FocusRequest request) async {
    try {
      await windowManager.focus();

      return FocusResponse(success: true);
    } catch (e) {
      return FocusResponse(success: false, error: e.toString());
    }
  }
}
