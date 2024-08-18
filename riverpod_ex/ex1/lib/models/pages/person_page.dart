import 'package:ex1/models/person.dart';
import 'package:flutter/material.dart';

class PersonPage extends StatelessWidget {
  const PersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final person1 = Person(id: 1, name: 'james', email: 'kim423@naver.com');
    final person2 = person1.copyWith(id: 2, email: "jaeyeon423@gmail.com");
    print(person1);
    print(person2);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person'),
      ),
    );
  }
}
