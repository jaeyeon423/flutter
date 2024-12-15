import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifier_provider/models/activity.dart';
import 'package:notifier_provider/pages/enum_activity/enum_activity_page.dart';
import 'package:notifier_provider/pages/sealed_activity/sealed_activity_state.dart';
import 'package:notifier_provider/pages/sealed_activity/sealed_provider.dart';

class SealedActivityPage extends ConsumerStatefulWidget {
  const SealedActivityPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SealedActivityPageState();
}

class _SealedActivityPageState extends ConsumerState<SealedActivityPage> {
  Widget? prevWidget;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(sealedActivityProvider.notifier).fetchActivity(activityTypes[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<SealedActivityState>(
      sealedActivityProvider,
      (previous, next) {
        switch (next) {
          case SealedActivityFailure(error: String error):
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(next.error),
                );
              },
            );
          case _:
        }
      },
    );

    final activityState = ref.watch(sealedActivityProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sealed Activity'),
      ),
      body: switch (activityState) {
        SealedActivityInitial() => const Center(
            child: Text(
              'Initial',
              style: TextStyle(fontSize: 24),
            ),
          ),
        SealedActivityLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
        SealedActivityFailure() => prevWidget == null
            ? Center(
                child: Text(
                  activityState.error,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                  ),
                ),
              )
            : prevWidget!,
        SealedActivitySuccess(activity: Activity activity) => ActivityWidget(
            activity: activity,
          ),
      },
    );
  }
}
