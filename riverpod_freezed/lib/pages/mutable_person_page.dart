import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_freezed/models/mutable_person.dart';

class MutablePersonPage extends StatelessWidget {
  const MutablePersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final person1 = MutablePerson(id: 1, name: 'jonh', email: 'email1');

    person1.name = 'jaeyteon';

    print(person1);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutable Person Page'),
      ),
    );
  }
}
