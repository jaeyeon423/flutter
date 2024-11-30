import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/pages/auto_dispose/auto_dispose_provider.dart';

class AutoDisposePage extends ConsumerWidget {
  const AutoDisposePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final autoDisposeHello = ref.watch(autoDisposeHelloProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoDisposeProvider'),
      ),
      body: Center(
        child: Text('$autoDisposeHello', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
