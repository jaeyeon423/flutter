import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/src/app.dart';
import 'package:insta_clone/src/binding/init_binding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black),
        )
      ),
      initialBinding: InitBinding(),
      // ignore: prefer_const_constructors
      home: App(),
    );
  }
}

