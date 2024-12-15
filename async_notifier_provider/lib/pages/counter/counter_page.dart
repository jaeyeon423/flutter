import 'package:async_notifier_provider/pages/counter/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    print(counter);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: counter.when(
          data: (count) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${counter.value}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      onPressed: () =>
                          ref.read(counterProvider.notifier).increment(),
                      child: const Icon(Icons.add),
                    ),
                    FloatingActionButton(
                      onPressed: () =>
                          ref.read(counterProvider.notifier).decrement(),
                      child: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ],
            );
          },
          error: (error, stackTrace) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  ref.invalidate(counterProvider);
                },
                child: Text(
                  'Refresh',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              )
            ],
          ),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}
