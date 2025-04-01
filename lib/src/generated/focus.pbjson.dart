//
//  Generated code. Do not modify.
//  source: focus.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use focusRequestDescriptor instead')
const FocusRequest$json = {
  '1': 'FocusRequest',
  '2': [
    {'1': 'metadata', '3': 1, '4': 1, '5': 12, '10': 'metadata'},
  ],
};

/// Descriptor for `FocusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List focusRequestDescriptor = $convert.base64Decode(
    'CgxGb2N1c1JlcXVlc3QSGgoIbWV0YWRhdGEYASABKAxSCG1ldGFkYXRh');

@$core.Deprecated('Use focusResponseDescriptor instead')
const FocusResponse$json = {
  '1': 'FocusResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `FocusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List focusResponseDescriptor = $convert.base64Decode(
    'Cg1Gb2N1c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSFAoFZXJyb3IYAiABKA'
    'lSBWVycm9y');

