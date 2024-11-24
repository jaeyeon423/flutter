// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_freezed/models/person.dart';

class PersonPage extends StatelessWidget {
  const PersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final person1 = Person(id: 1, name: 'Person 1', email: 'email1');
    print(person1);
    final person2 = Person(id: 1, name: 'Person 1', email: 'email1');
    print(person1 == person2);
    final perons3 = person1.copyWith(id: 2, email: 'email2');
    print(perons3);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Person Page'),
      ),
      body: const Center(
        child: Text('Person Page'),
      ),
    );
  }
}
