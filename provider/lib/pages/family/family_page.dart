import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/pages/family/family_provider.dart';

class FamilyPage extends ConsumerWidget {
  const FamilyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helloJohn = ref.watch(familyHelloProvider('John'));
    final helloJ = ref.watch(familyHelloProvider('J'));
    return Scaffold(
      appBar: AppBar(
        title: const Text('FamilyProvider'),
      ),
      body: Center(
          child: Column(
        children: [
          Text('$helloJohn', style: TextStyle(fontSize: 24)),
          Text('$helloJ', style: TextStyle(fontSize: 24)),
        ],
      )),
    );
  }
}
