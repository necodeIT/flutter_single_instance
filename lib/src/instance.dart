import 'package:freezed_annotation/freezed_annotation.dart';

part 'instance.freezed.dart';
part 'instance.g.dart';

/// Represents an instance of the app.
@freezed
class Instance with _$Instance {
  /// Represents an instance of the app.
  factory Instance({
    /// The port of the grpc server.
    required int port,

    /// The process id of the instance.
    required int pid,
  }) = _Instance;

  /// Creates an instance from a json map.
  factory Instance.fromJson(Map<String, dynamic> json) =>
      _$InstanceFromJson(json);
}
