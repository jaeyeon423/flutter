import 'package:riverpod_annotation/riverpod_annotation.dart';

class Counter extends AsyncNotifier<int> {
  @override
  FutureOr<int> build() async {
    await waitSecont();
    return 0;
  }

  Future<void> waitSecont() => Future.delayed(const Duration(seconds: 1));

  Future<void> increment() async {
    state = const AsyncLoading();

    try {
      await waitSecont();
      state = AsyncData(state.value! + 1);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> decrement() async {
    state = const AsyncLoading();
    try {
      await waitSecont();
      throw 'Fail to decrement';
      state = AsyncData(state.value! - 1);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}

final counterProvider = AsyncNotifierProvider<Counter, int>(Counter.new);
