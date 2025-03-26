import 'package:flutter/material.dart';
import 'package:freezed_ex/models/person.dart';

class PersonPage extends StatelessWidget {
  const PersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final person1 = Person(id: 1, name: 'jaeyeon', email: 'kim423@naver.com');
    print(person1);
    final person2 = Person(id: 1, name: 'jaeyeon', email: 'kim423@naver.com');
    print(person1 == person2);

    final person3 = person1.copyWith(id: 2);
    print(person1 == person3);
    return Scaffold(
      appBar: AppBar(title: const Text('Person Page')),
      body: Center(),
    );
  }
}
