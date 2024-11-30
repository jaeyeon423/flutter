// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'basic_provider.g.dart';

// final helloProvider = Provider<String>((ref) {
//   ref.onDispose(() {
//     print("[helloProvider] onDispose");
//   });
//   return "hello";
// });

// final worldProvider = Provider<String>((ref) {
//   ref.onDispose(() {
//     print("[worldProvider] onDispose");
//   });
//   return "world";
// });

@Riverpod(keepAlive: true)
String hello(HelloRef ref) {
  ref.onDispose(() {
    print("[helloProvider] onDispose");
  });
  return "hello";
}

@Riverpod(keepAlive: true)
String world(WorldRef ref) {
  ref.onDispose(() {
    print("[worldProvider] onDispose");
  });
  return "world";
}
