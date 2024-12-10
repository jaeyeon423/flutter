// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notifier_provider/models/activity.dart';
import 'package:notifier_provider/pages/enum_activity/enum_activity_provider.dart';
import 'package:notifier_provider/pages/enum_activity/enum_activity_state.dart';

class EnumActivityPage extends ConsumerStatefulWidget {
  const EnumActivityPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EnumActivityPageState();
}

class _EnumActivityPageState extends ConsumerState<EnumActivityPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(enumActivityProvider.notifier).fetchActivity(activityTypes[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final activityState = ref.watch(enumActivityProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enum Activity'),
      ),
      body: switch (activityState.status) {
        ActivityStatus.initial => const Center(
            child: Text(
              'Initial',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ActivityStatus.loading => const Center(
            child: CircularProgressIndicator(),
          ),
        ActivityStatus.success =>
          ActivityWidget(activity: activityState.activity),
        ActivityStatus.failure => Center(
            child: Text(
              activityState.error,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.red,
              ),
            ),
          ),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final randomNumber = Random().nextInt(activityTypes.length);
          ref
              .read(enumActivityProvider.notifier)
              .fetchActivity(activityTypes[randomNumber]);
        },
        tooltip: 'new Activity',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ActivityWidget extends ConsumerWidget {
  final Activity activity;
  const ActivityWidget({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            activity.type,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const Divider(),
          BulletedList(
            listItems: [
              'activity: ${activity.activity}',
              'accessibility: ${activity.accessibility}',
              'type: ${activity.type}',
              'participants: ${activity.participants}',
              'price: ${activity.price}',
              'key: ${activity.key}',
            ],
            style: Theme.of(context).textTheme.bodyLarge,
            bullet: const Icon(
              Icons.check,
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}
