import 'package:flutter_single_instance/flutter_single_instance.dart';
import 'package:flutter_single_instance/src/generated/focus.pbgrpc.dart';
import 'package:grpc/grpc.dart';

/// Handles focus requests from other instances.
class FocusService extends FocusServiceBase {
  @override
  Future<FocusResponse> focus(ServiceCall call, FocusRequest request) async {
    // ignore: invalid_use_of_protected_member
    final logger = FlutterSingleInstance().logger;

    logger.finest('Received focus request from ${call.remoteAddress?.address}');

    try {
      await windowManager.focus();

      logger.finest('Window focused');

      return FocusResponse(success: true);
    } catch (e) {
      logger.finest('Failed to focus window', e);

      return FocusResponse(success: false, error: e.toString());
    }
  }
}
