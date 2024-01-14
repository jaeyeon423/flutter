import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestView(),
    );
  }
}

class TestView extends ConsumerWidget {
  TestView({Key? key}) : super(key: key);
  final counterProvider = StateNotifierProvider((ref) => Counter());

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final count = ref.watch(counterProvider);
    ref.listen(counterProvider, (previous, next) {
      print("current : $previous, $next");
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('RiverPod ex'),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Count : ${count.toString()}"),
            TextButton(onPressed: () => ref.watch(counterProvider.notifier).increament() , child: Text('Increment'))
          ],
        ),
      ),
    );
  }
}

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increament() => state++;
}