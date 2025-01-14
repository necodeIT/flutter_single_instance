//
//  Generated code. Do not modify.
//  source: focus.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'focus.pb.dart' as $0;

export 'focus.pb.dart';

@$pb.GrpcServiceName('flutter_single_instance.FocusService')
class FocusServiceClient extends $grpc.Client {
  static final _$focus = $grpc.ClientMethod<$0.FocusRequest, $0.FocusResponse>(
      '/flutter_single_instance.FocusService/Focus',
      ($0.FocusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.FocusResponse.fromBuffer(value));

  FocusServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.FocusResponse> focus($0.FocusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$focus, request, options: options);
  }
}

@$pb.GrpcServiceName('flutter_single_instance.FocusService')
abstract class FocusServiceBase extends $grpc.Service {
  $core.String get $name => 'flutter_single_instance.FocusService';

  FocusServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.FocusRequest, $0.FocusResponse>(
        'Focus',
        focus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FocusRequest.fromBuffer(value),
        ($0.FocusResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.FocusResponse> focus_Pre($grpc.ServiceCall call, $async.Future<$0.FocusRequest> request) async {
    return focus(call, await request);
  }

  $async.Future<$0.FocusResponse> focus($grpc.ServiceCall call, $0.FocusRequest request);
}
