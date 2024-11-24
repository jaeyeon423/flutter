import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_freezed/models/method.dart';

class MethodPage extends StatelessWidget {
  const MethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    const method1 = Method('methodName1');
    print(method1);

    const method2 = Method('methodName2', version: 1.0);
    print(method2);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Method Page'),
      ),
    );
  }
}
