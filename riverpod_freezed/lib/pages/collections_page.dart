import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_freezed/models/collections.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final Immutable = ImmutableColl([]);
    final mutable = MutableColl([]);
    mutable.list.add(41);
    print(mutable);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections Page'),
      ),
    );
  }
}
