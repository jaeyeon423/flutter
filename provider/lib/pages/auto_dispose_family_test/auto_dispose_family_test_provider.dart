// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter extends Equatable {
  final int count;
  const Counter({required this.count});

  @override
  String toString() {
    // TODO: implement toString
    return 'Counter(count: $count)';
  }

  @override
  List<Object> get props => [count];
}

final counterProvider = Provider.autoDispose.family<int, Counter>((ref, arg) {
  ref.onDispose(() {
    print("[counterProvider] onDispose");
  });
  return arg.count;
});

final autoDisposefamilyTestHelloProvider =
    Provider.autoDispose.family<String, String>((ref, name) {
  ref.onDispose(() {
    print("[autoDisposefamilyTestHelloProvider($name)] onDispose");
  });
  return "hello $name";
});
