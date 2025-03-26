import 'package:flutter/material.dart';
import 'package:freezed_ex/pages/mutable_person_page.dart';
import 'package:freezed_ex/pages/person_page.dart';
import 'package:freezed_ex/widgets/custom_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freezed Data Class',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
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
          padding: const EdgeInsets.all(20),
          children: [
            CustomButton(title: 'Person', child: PersonPage()),
            CustomButton(title: 'Mutable Person', child: MutablePersonPage()),
          ],
        ),
      ),
    );
  }
}
