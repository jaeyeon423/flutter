import 'package:flutter/material.dart';
import 'package:riverpod_freezed/pages/collections_page.dart';
import 'package:riverpod_freezed/pages/method_page.dart';
import 'package:riverpod_freezed/pages/mutable_person_page.dart';
import 'package:riverpod_freezed/pages/person_page.dart';
import 'package:riverpod_freezed/widgets/custom_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          children: [
            CustomButton(title: 'Persoh', child: PersonPage()),
            CustomButton(title: 'Mutable Persoh', child: MutablePersonPage()),
            CustomButton(title: 'Collections Persoh', child: CollectionsPage()),
            CustomButton(title: 'Method Persoh', child: MethodPage()),
          ],
        ),
      ),
    );
  }
}
