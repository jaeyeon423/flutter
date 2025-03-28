import 'package:flutter/material.dart';
import 'package:freezed_ex/models/collections.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final immutableColl = mutableColl([]);
    immutableColl.list.add(1);

    return Scaffold(appBar: AppBar(title: const Text('Collections Page')));
  }
}
