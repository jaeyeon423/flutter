import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'collections.freezed.dart';

@freezed
abstract class ImmutableColl with _$ImmutableColl {
  const factory ImmutableColl(List<int> list) = _ImmutableColl;
}

@Freezed(makeCollectionsUnmodifiable: false)
abstract class mutableColl with _$mutableColl {
  const factory mutableColl(List<int> list) = _IutableColl;
}
