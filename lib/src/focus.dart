import 'dart:convert';

import 'package:flutter_single_instance/flutter_single_instance.dart';
import 'package:flutter_single_instance/src/generated/focus.pbgrpc.dart';
import 'package:grpc/grpc.dart';

/// Handles focus requests from other instances.
class FocusService extends FocusServiceBase {
  @override
  Future<FocusResponse> focus(ServiceCall call, FocusRequest request) async {
    // whe're still in the same package and should log with the same logger
    // ignore: invalid_use_of_protected_member
    final logger = FlutterSingleInstance().logger;

    logger.finest('Received focus request from another instance');

    if (FlutterSingleInstance.onFocus != null) {
      try {
        final metadata =
            jsonDecode(utf8.decode(request.metadata)) as Map<String, dynamic>;

        await FlutterSingleInstance.onFocus!(metadata);

        logger.finest('onFocus hook executed with $metadata');
      } catch (e, s) {
        logger.finest('Failed to run onFocus hook', e, s);
      }
    }

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
