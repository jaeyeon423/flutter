import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'login_app/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'login Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: LogIn(),
    );
  }
}
