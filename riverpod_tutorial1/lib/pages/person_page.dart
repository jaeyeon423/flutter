import 'package:flutter/material.dart';
import 'package:riverpod_tutorial1/models/person.dart';

class PersonPage extends StatelessWidget {
  const PersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final person1 =
        Person(id: 1, name: 'jaeyeon', email: 'jaeyeon423@gmail.com');
    final person2 = person1.copyWith();
    print(person1);
    print(person2);
    print(person1 == person2);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person Page'),
      ),
    );
  }
}
