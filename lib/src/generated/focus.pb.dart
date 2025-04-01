//
//  Generated code. Do not modify.
//  source: focus.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class FocusRequest extends $pb.GeneratedMessage {
  factory FocusRequest({
    $core.List<$core.int>? metadata,
  }) {
    final $result = create();
    if (metadata != null) {
      $result.metadata = metadata;
    }
    return $result;
  }
  FocusRequest._() : super();
  factory FocusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FocusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FocusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'flutter_single_instance'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'metadata', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FocusRequest clone() => FocusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FocusRequest copyWith(void Function(FocusRequest) updates) => super.copyWith((message) => updates(message as FocusRequest)) as FocusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FocusRequest create() => FocusRequest._();
  FocusRequest createEmptyInstance() => create();
  static $pb.PbList<FocusRequest> createRepeated() => $pb.PbList<FocusRequest>();
  @$core.pragma('dart2js:noInline')
  static FocusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FocusRequest>(create);
  static FocusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get metadata => $_getN(0);
  @$pb.TagNumber(1)
  set metadata($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMetadata() => $_has(0);
  @$pb.TagNumber(1)
  void clearMetadata() => clearField(1);
}

class FocusResponse extends $pb.GeneratedMessage {
  factory FocusResponse({
    $core.bool? success,
    $core.String? error,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (error != null) {
      $result.error = error;
    }
    return $result;
  }
  FocusResponse._() : super();
  factory FocusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FocusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FocusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'flutter_single_instance'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FocusResponse clone() => FocusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FocusResponse copyWith(void Function(FocusResponse) updates) => super.copyWith((message) => updates(message as FocusResponse)) as FocusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FocusResponse create() => FocusResponse._();
  FocusResponse createEmptyInstance() => create();
  static $pb.PbList<FocusResponse> createRepeated() => $pb.PbList<FocusResponse>();
  @$core.pragma('dart2js:noInline')
  static FocusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FocusResponse>(create);
  static FocusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
