import 'package:notifier_provider/models/activity.dart';
import 'package:notifier_provider/pages/enum_activity/enum_activity_state.dart';
import 'package:notifier_provider/providers/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'enum_activity_provider.g.dart';

@riverpod
class EnumActivity extends _$EnumActivity {
  int _errorCounter = 0;
  @override
  EnumActivityState build() {
    ref.onDispose(() {
      print('[EnumActivityProvider] onDispose');
    });

    return EnumActivityState.initial();
  }

  Future<void> fetchActivity(String activityType) async {
    state = state.copyWith(status: ActivityStatus.loading);
    print(activityType);

    try {
      print('_errorCounter: $_errorCounter');
      if (_errorCounter++ % 2 == 1) {
        await Future.delayed(Duration(seconds: 5));
        throw 'Fail to fetch activity';
      }
      final response = await ref.read(dioProvider).get('?type=$activityType');
      print(response);
      final activity = Activity.fromJson(response.data[0]);

      state =
          state.copyWith(status: ActivityStatus.success, activity: activity);
    } catch (e) {
      // print(e);
      state = state.copyWith(
        status: ActivityStatus.failure,
        error: e.toString(),
      );
    }
  }
}
