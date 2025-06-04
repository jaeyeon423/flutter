// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'anonymous_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AnonymousUser _$AnonymousUserFromJson(Map<String, dynamic> json) {
  return _AnonymousUser.fromJson(json);
}

/// @nodoc
mixin _$AnonymousUser {
  String get uid => throw _privateConstructorUsedError;

  /// Serializes this AnonymousUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnonymousUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnonymousUserCopyWith<AnonymousUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnonymousUserCopyWith<$Res> {
  factory $AnonymousUserCopyWith(
          AnonymousUser value, $Res Function(AnonymousUser) then) =
      _$AnonymousUserCopyWithImpl<$Res, AnonymousUser>;
  @useResult
  $Res call({String uid});
}

/// @nodoc
class _$AnonymousUserCopyWithImpl<$Res, $Val extends AnonymousUser>
    implements $AnonymousUserCopyWith<$Res> {
  _$AnonymousUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnonymousUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnonymousUserImplCopyWith<$Res>
    implements $AnonymousUserCopyWith<$Res> {
  factory _$$AnonymousUserImplCopyWith(
          _$AnonymousUserImpl value, $Res Function(_$AnonymousUserImpl) then) =
      __$$AnonymousUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uid});
}

/// @nodoc
class __$$AnonymousUserImplCopyWithImpl<$Res>
    extends _$AnonymousUserCopyWithImpl<$Res, _$AnonymousUserImpl>
    implements _$$AnonymousUserImplCopyWith<$Res> {
  __$$AnonymousUserImplCopyWithImpl(
      _$AnonymousUserImpl _value, $Res Function(_$AnonymousUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnonymousUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
  }) {
    return _then(_$AnonymousUserImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnonymousUserImpl implements _AnonymousUser {
  const _$AnonymousUserImpl({required this.uid});

  factory _$AnonymousUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnonymousUserImplFromJson(json);

  @override
  final String uid;

  @override
  String toString() {
    return 'AnonymousUser(uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnonymousUserImpl &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uid);

  /// Create a copy of AnonymousUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnonymousUserImplCopyWith<_$AnonymousUserImpl> get copyWith =>
      __$$AnonymousUserImplCopyWithImpl<_$AnonymousUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnonymousUserImplToJson(
      this,
    );
  }
}

abstract class _AnonymousUser implements AnonymousUser {
  const factory _AnonymousUser({required final String uid}) =
      _$AnonymousUserImpl;

  factory _AnonymousUser.fromJson(Map<String, dynamic> json) =
      _$AnonymousUserImpl.fromJson;

  @override
  String get uid;

  /// Create a copy of AnonymousUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnonymousUserImplCopyWith<_$AnonymousUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
