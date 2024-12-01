import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auto_dispose_provider.g.dart';

final autoDisposeCounterProvider = StateProvider.autoDispose<int>((ref) {
  ref.onDispose(() {
    print('[autoDisposeCounterProvider] onDispose');
  });
  return 0;
});

@Riverpod(keepAlive: false)
String autoDisposeAge(AutoDisposeAgeRef ref) {
  final age = ref.watch(autoDisposeCounterProvider);
  ref.onDispose(() {
    print('[autoDisposeAge] onDispose');
  });
  return '$age';
}
