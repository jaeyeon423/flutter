import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/pages/auto_dispose_family_test/auto_dispose_family_test_provider.dart';

class AutoDisposeFamilyTestPage extends ConsumerStatefulWidget {
  const AutoDisposeFamilyTestPage({super.key});

  @override
  ConsumerState<AutoDisposeFamilyTestPage> createState() =>
      _AutoDisposeFamilyTestPageState();
}

class _AutoDisposeFamilyTestPageState
    extends ConsumerState<AutoDisposeFamilyTestPage> {
  String name = 'john';
  @override
  Widget build(BuildContext context) {
    final helloThere = ref.watch(autoDisposefamilyTestHelloProvider(name));
    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoDisposeFamilyProvider'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              '$helloThere',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            FilledButton(
                onPressed: () {
                  setState(() {
                    name = name == 'john' ? 'jane' : 'john';
                  });
                },
                child: Text('Change Name')),
          ],
        ),
      ),
    );
  }
}
