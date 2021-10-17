import 'package:flutter/material.dart';
import 'package:getx_tutorial/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'getx tutorial',
      home: HomePage(),
    );
  }
}


