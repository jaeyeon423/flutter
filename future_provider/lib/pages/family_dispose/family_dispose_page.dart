import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:future_provider/pages/users/users_providers.dart';

class FamilyDisposePage extends ConsumerWidget {
  const FamilyDisposePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(UserDetailProvider(1));
    ref.watch(UserDetailProvider(2));

    return Scaffold(
        appBar: AppBar(
          title: const Text('Family Dispose'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          children: [
            OutlinedButton(
              onPressed: () {
                ref.invalidate(userDetailProvider);
              },
              child: Text(
                'Invalidate',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: () {
                ref.refresh(userDetailProvider(1));
              },
              child: Text(
                'refresh',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ));
  }
}
