import 'package:flutter/material.dart';
import 'package:riverpod_tutorial1/pages/person_page.dart';
import 'package:riverpod_tutorial1/pages/user_list_page.dart';
import 'package:riverpod_tutorial1/widgets/custom_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8.0),
          children: [
            CustomButton(
              title: 'Person',
              child: PersonPage(),
            ),
            CustomButton(
              title: 'user Lsit',
              child: UserListPage(),
            ),
          ],
        ),
      ),
    );
  }
}
