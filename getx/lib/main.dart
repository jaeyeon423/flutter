import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/src/home.dart';
import 'package:getx/src/pages/named/first.dart';
import 'package:getx/src/pages/named/second.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: "/", page: ()=> Home(), transition: Transition.cupertinoDialog),
        GetPage(name: "/first", page: ()=> FirstNamedPage(), transition: Transition.cupertinoDialog),
        GetPage(name: "/second", page: ()=> SecondNamedPage(), transition: Transition.cupertinoDialog),
      ],
    );
  }
}

