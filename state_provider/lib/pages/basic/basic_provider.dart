import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'basic_provider.g.dart';

final counterProvider = StateProvider<int>((ref) {
  ref.onDispose(() {
    print('[counterProvider] onDispose');
  });
  return 0;
});

@Riverpod(keepAlive: true)
String age(AgeRef ref) {
  final age = ref.watch(counterProvider);
  ref.onDispose(() {
    print('[age] onDispose');
  });
  return '$age';
}
