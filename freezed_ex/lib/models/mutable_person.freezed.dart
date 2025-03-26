// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mutable_person.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MutablePerson implements DiagnosticableTreeMixin {

 int get id; String get name; set name(String value); String get email; set email(String value);
/// Create a copy of MutablePerson
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MutablePersonCopyWith<MutablePerson> get copyWith => _$MutablePersonCopyWithImpl<MutablePerson>(this as MutablePerson, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MutablePerson'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('email', email));
}



@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MutablePerson(id: $id, name: $name, email: $email)';
}


}

/// @nodoc
abstract mixin class $MutablePersonCopyWith<$Res>  {
  factory $MutablePersonCopyWith(MutablePerson value, $Res Function(MutablePerson) _then) = _$MutablePersonCopyWithImpl;
@useResult
$Res call({
 int id, String name, String email
});




}
/// @nodoc
class _$MutablePersonCopyWithImpl<$Res>
    implements $MutablePersonCopyWith<$Res> {
  _$MutablePersonCopyWithImpl(this._self, this._then);

  final MutablePerson _self;
  final $Res Function(MutablePerson) _then;

/// Create a copy of MutablePerson
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _MutablePerson with DiagnosticableTreeMixin implements MutablePerson {
   _MutablePerson({required this.id, required this.name, required this.email});
  

@override final  int id;
@override  String name;
@override  String email;

/// Create a copy of MutablePerson
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MutablePersonCopyWith<_MutablePerson> get copyWith => __$MutablePersonCopyWithImpl<_MutablePerson>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MutablePerson'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('email', email));
}



@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MutablePerson(id: $id, name: $name, email: $email)';
}


}

/// @nodoc
abstract mixin class _$MutablePersonCopyWith<$Res> implements $MutablePersonCopyWith<$Res> {
  factory _$MutablePersonCopyWith(_MutablePerson value, $Res Function(_MutablePerson) _then) = __$MutablePersonCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String email
});




}
/// @nodoc
class __$MutablePersonCopyWithImpl<$Res>
    implements _$MutablePersonCopyWith<$Res> {
  __$MutablePersonCopyWithImpl(this._self, this._then);

  final _MutablePerson _self;
  final $Res Function(_MutablePerson) _then;

/// Create a copy of MutablePerson
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = null,}) {
  return _then(_MutablePerson(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
