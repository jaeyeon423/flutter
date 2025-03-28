// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collections.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImmutableColl implements DiagnosticableTreeMixin {

 List<int> get list;
/// Create a copy of ImmutableColl
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImmutableCollCopyWith<ImmutableColl> get copyWith => _$ImmutableCollCopyWithImpl<ImmutableColl>(this as ImmutableColl, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ImmutableColl'))
    ..add(DiagnosticsProperty('list', list));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImmutableColl&&const DeepCollectionEquality().equals(other.list, list));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(list));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ImmutableColl(list: $list)';
}


}

/// @nodoc
abstract mixin class $ImmutableCollCopyWith<$Res>  {
  factory $ImmutableCollCopyWith(ImmutableColl value, $Res Function(ImmutableColl) _then) = _$ImmutableCollCopyWithImpl;
@useResult
$Res call({
 List<int> list
});




}
/// @nodoc
class _$ImmutableCollCopyWithImpl<$Res>
    implements $ImmutableCollCopyWith<$Res> {
  _$ImmutableCollCopyWithImpl(this._self, this._then);

  final ImmutableColl _self;
  final $Res Function(ImmutableColl) _then;

/// Create a copy of ImmutableColl
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,}) {
  return _then(_self.copyWith(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// @nodoc


class _ImmutableColl with DiagnosticableTreeMixin implements ImmutableColl {
  const _ImmutableColl(final  List<int> list): _list = list;
  

 final  List<int> _list;
@override List<int> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}


/// Create a copy of ImmutableColl
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImmutableCollCopyWith<_ImmutableColl> get copyWith => __$ImmutableCollCopyWithImpl<_ImmutableColl>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ImmutableColl'))
    ..add(DiagnosticsProperty('list', list));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImmutableColl&&const DeepCollectionEquality().equals(other._list, _list));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ImmutableColl(list: $list)';
}


}

/// @nodoc
abstract mixin class _$ImmutableCollCopyWith<$Res> implements $ImmutableCollCopyWith<$Res> {
  factory _$ImmutableCollCopyWith(_ImmutableColl value, $Res Function(_ImmutableColl) _then) = __$ImmutableCollCopyWithImpl;
@override @useResult
$Res call({
 List<int> list
});




}
/// @nodoc
class __$ImmutableCollCopyWithImpl<$Res>
    implements _$ImmutableCollCopyWith<$Res> {
  __$ImmutableCollCopyWithImpl(this._self, this._then);

  final _ImmutableColl _self;
  final $Res Function(_ImmutableColl) _then;

/// Create a copy of ImmutableColl
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,}) {
  return _then(_ImmutableColl(
null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

/// @nodoc
mixin _$mutableColl implements DiagnosticableTreeMixin {

 List<int> get list;
/// Create a copy of mutableColl
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$mutableCollCopyWith<mutableColl> get copyWith => _$mutableCollCopyWithImpl<mutableColl>(this as mutableColl, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'mutableColl'))
    ..add(DiagnosticsProperty('list', list));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is mutableColl&&const DeepCollectionEquality().equals(other.list, list));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(list));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'mutableColl(list: $list)';
}


}

/// @nodoc
abstract mixin class $mutableCollCopyWith<$Res>  {
  factory $mutableCollCopyWith(mutableColl value, $Res Function(mutableColl) _then) = _$mutableCollCopyWithImpl;
@useResult
$Res call({
 List<int> list
});




}
/// @nodoc
class _$mutableCollCopyWithImpl<$Res>
    implements $mutableCollCopyWith<$Res> {
  _$mutableCollCopyWithImpl(this._self, this._then);

  final mutableColl _self;
  final $Res Function(mutableColl) _then;

/// Create a copy of mutableColl
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,}) {
  return _then(_self.copyWith(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// @nodoc


class _IutableColl with DiagnosticableTreeMixin implements mutableColl {
  const _IutableColl(this.list);
  

@override final  List<int> list;

/// Create a copy of mutableColl
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IutableCollCopyWith<_IutableColl> get copyWith => __$IutableCollCopyWithImpl<_IutableColl>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'mutableColl'))
    ..add(DiagnosticsProperty('list', list));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IutableColl&&const DeepCollectionEquality().equals(other.list, list));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(list));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'mutableColl(list: $list)';
}


}

/// @nodoc
abstract mixin class _$IutableCollCopyWith<$Res> implements $mutableCollCopyWith<$Res> {
  factory _$IutableCollCopyWith(_IutableColl value, $Res Function(_IutableColl) _then) = __$IutableCollCopyWithImpl;
@override @useResult
$Res call({
 List<int> list
});




}
/// @nodoc
class __$IutableCollCopyWithImpl<$Res>
    implements _$IutableCollCopyWith<$Res> {
  __$IutableCollCopyWithImpl(this._self, this._then);

  final _IutableColl _self;
  final $Res Function(_IutableColl) _then;

/// Create a copy of mutableColl
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,}) {
  return _then(_IutableColl(
null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
