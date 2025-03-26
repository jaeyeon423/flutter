import 'package:flutter/material.dart';
import 'package:freezed_ex/models/mutable_person.dart';
import 'package:freezed_ex/models/person.dart';

class MutablePersonPage extends StatelessWidget {
  const MutablePersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final person1 = MutablePerson(
      id: 1,
      name: 'jaeyeon',
      email: 'kim423@naver.com',
    );
    print(person1);
    final person2 = MutablePerson(
      id: 1,
      name: 'jaeyeon',
      email: 'kim423@naver.com',
    );
    print(person1 == person2);

    final person3 = person1.copyWith(id: 2);
    print(person1 == person3);
    return Scaffold(
      appBar: AppBar(title: const Text('Person Page')),
      body: Center(),
    );
  }
}
