import 'package:notifier_provider/pages/sealed_activity/sealed_activity_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sealed_activity_provider.g.dart';

@riverpod
class SealedActivity extends _$SealedActivity {
  int _errorCount = 0;
  @override
  SealedActivityState build() {
    ref.onDispose(() {
      print('[SealedActivityProvider] onDispose');
    });
    return SealedActivityStateInitial();
  }
}
