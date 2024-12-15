import 'package:notifier_provider/models/activity.dart';
import 'package:notifier_provider/providers/dio_provider.dart';

import 'sealed_activity_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sealed_provider.g.dart';

@riverpod
class SealedActivity extends _$SealedActivity {
  int _errorCounter = 0;

  @override
  SealedActivityState build() {
    ref.onDispose(() {
      print('[sealedActivityProvider] disposed');
    });
    print('hashCode: $hashCode');
    return const SealedActivityInitial();
  }

  Future<void> fetchActivity(String activityType) async {
    print('hashCode in fetchActivity: $hashCode');
    state = const SealedActivityLoading();

    try {
      print('_errorCounter: $_errorCounter');
      if (_errorCounter++ % 2 == 1) {
        await Future.delayed(Duration(seconds: 5));
        throw 'Fail to fetch sealed activity';
      }

      final response = await ref.read(dioProvider).get('?type=$activityType');

      final activity = Activity.fromJson(response.data[0]);

      state = SealedActivitySuccess(activity: activity);
    } catch (e) {
      state = SealedActivityFailure(error: e.toString());
    }
  }
}
