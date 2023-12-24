import 'package:course1_roll_dice/widgets/expenses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 220, 189, 252),
      ),
      home: Expenses(),
    );
  }
}
