import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_provider/pages/ticker/ticker_provider.dart';

class TickerPage extends ConsumerWidget {
  const TickerPage({super.key});

  String zeroPaddedTwoDigits(double ticks) {
    return ticks.floor().toString().padLeft(2, '0');
  }

  String formatTimer(int ticks) {
    final minute = zeroPaddedTwoDigits((ticks / 60) % 60);
    final second = zeroPaddedTwoDigits(ticks % 60);
    return '$minute:$second';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tickerValue = ref.watch(tickerProvider);
    print(tickerValue);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticker'),
      ),
      body: Center(
          child: tickerValue.when(
        data: (ticks) => Text(
          formatTimer(ticks),
          style: const TextStyle(fontSize: 50),
        ),
        error: (e, st) => Text(
          e.toString(),
          style: TextStyle(color: Colors.red),
        ),
        loading: () => const CircularProgressIndicator(),
      )),
    );
  }
}
