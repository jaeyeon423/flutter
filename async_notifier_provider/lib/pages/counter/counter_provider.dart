import 'package:riverpod_annotation/riverpod_annotation.dart';

class Counter extends AsyncNotifier<int> {
  @override
  FutureOr<int> build() {
    ref.onDispose(() {
      print('[Counter] onDispose');
    });

    return 0;
  }
  // @override
  // FutureOr<int> build() async {
  //   ref.onDispose(() {
  //     print('[Counter] onDispose');
  //   });

  //   await waitSecont();
  //   return 0;
  // }

  Future<void> waitSecont() => Future.delayed(const Duration(seconds: 1));

  Future<void> increment() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await waitSecont();
      if (state.value! == 2) {
        throw 'Fail to increment';
      }
      return state.value! + 1;
    });

    // try {
    //   await waitSecont();
    //   state = AsyncData(state.value! + 1);
    // } catch (error, stackTrace) {
    //   state = AsyncError(error, stackTrace);
    // }
  }

  Future<void> decrement() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await waitSecont();
      return state.value! - 1;
    });
    // try {
    //   await waitSecont();
    //   throw 'Fail to decrement';
    //   state = AsyncData(state.value! - 1);
    // } catch (error, stackTrace) {
    //   state = AsyncError(error, stackTrace);
    // }
  }
}

final counterProvider = AsyncNotifierProvider<Counter, int>(Counter.new);
