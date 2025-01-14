// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'instance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Instance _$InstanceFromJson(Map<String, dynamic> json) {
  return _Instance.fromJson(json);
}

/// @nodoc
mixin _$Instance {
  /// The port of the grpc server.
  int get port => throw _privateConstructorUsedError;

  /// The process id of the instance.
  int get pid => throw _privateConstructorUsedError;

  /// Serializes this Instance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Instance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InstanceCopyWith<Instance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InstanceCopyWith<$Res> {
  factory $InstanceCopyWith(Instance value, $Res Function(Instance) then) =
      _$InstanceCopyWithImpl<$Res, Instance>;
  @useResult
  $Res call({int port, int pid});
}

/// @nodoc
class _$InstanceCopyWithImpl<$Res, $Val extends Instance>
    implements $InstanceCopyWith<$Res> {
  _$InstanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Instance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? port = null,
    Object? pid = null,
  }) {
    return _then(_value.copyWith(
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      pid: null == pid
          ? _value.pid
          : pid // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InstanceImplCopyWith<$Res>
    implements $InstanceCopyWith<$Res> {
  factory _$$InstanceImplCopyWith(
          _$InstanceImpl value, $Res Function(_$InstanceImpl) then) =
      __$$InstanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int port, int pid});
}

/// @nodoc
class __$$InstanceImplCopyWithImpl<$Res>
    extends _$InstanceCopyWithImpl<$Res, _$InstanceImpl>
    implements _$$InstanceImplCopyWith<$Res> {
  __$$InstanceImplCopyWithImpl(
      _$InstanceImpl _value, $Res Function(_$InstanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Instance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? port = null,
    Object? pid = null,
  }) {
    return _then(_$InstanceImpl(
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      pid: null == pid
          ? _value.pid
          : pid // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InstanceImpl implements _Instance {
  _$InstanceImpl({required this.port, required this.pid});

  factory _$InstanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$InstanceImplFromJson(json);

  /// The port of the grpc server.
  @override
  final int port;

  /// The process id of the instance.
  @override
  final int pid;

  @override
  String toString() {
    return 'Instance(port: $port, pid: $pid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InstanceImpl &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.pid, pid) || other.pid == pid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, port, pid);

  /// Create a copy of Instance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InstanceImplCopyWith<_$InstanceImpl> get copyWith =>
      __$$InstanceImplCopyWithImpl<_$InstanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InstanceImplToJson(
      this,
    );
  }
}

abstract class _Instance implements Instance {
  factory _Instance({required final int port, required final int pid}) =
      _$InstanceImpl;

  factory _Instance.fromJson(Map<String, dynamic> json) =
      _$InstanceImpl.fromJson;

  /// The port of the grpc server.
  @override
  int get port;

  /// The process id of the instance.
  @override
  int get pid;

  /// Create a copy of Instance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InstanceImplCopyWith<_$InstanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
