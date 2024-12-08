// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final tickerProvider = StreamProvider<int>((ref) {
//   ref.onDispose(() {
//     print('[TickerProvider] Disposed');
//   });
//   return Stream.periodic(const Duration(seconds: 1), (count) => count + 1)
//       .take(60);
// });

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ticker_provider.g.dart';

@riverpod
Stream<int> ticker(TickerRef ref) {
  ref.onDispose(() {
    print('[TickerProvider] Disposed');
  });
  return Stream.periodic(const Duration(seconds: 1), (count) => count + 1)
      .take(60);
}
