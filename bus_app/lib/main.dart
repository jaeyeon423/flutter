import 'package:bus_app/src/app.dart';
import 'package:bus_app/src/binding/init_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'hp bus app',
      initialBinding: InitBinding(),
      home: App(),
    );
  }
}
