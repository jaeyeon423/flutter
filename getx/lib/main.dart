import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/src/binding/binding_page.dart';
import 'package:getx/src/controller/count_controller_with_getx.dart';
import 'package:getx/src/controller/dependency_controller.dart';
import 'package:getx/src/home.dart';
import 'package:getx/src/pages/bindingpage.dart';
import 'package:getx/src/pages/named/first.dart';
import 'package:getx/src/pages/named/second.dart';
import 'package:getx/src/pages/next.dart';
import 'package:getx/src/pages/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
            name: "/",
            page: () => Home(),
            transition: Transition.cupertinoDialog),
        GetPage(
            name: "/first",
            page: () => FirstNamedPage(),
            transition: Transition.cupertinoDialog),
        GetPage(
            name: "/second",
            page: () => SecondNamedPage(),
            transition: Transition.cupertinoDialog),
        GetPage(
            name: "/next",
            page: () => NextPage(),
            transition: Transition.cupertinoDialog),
        GetPage(
            name: "/user/:uid",
            page: () => UserPage(),
            transition: Transition.cupertinoDialog),
        GetPage(
            name: "/binding",
            page: () => BindingPage(), binding: BindingPageBinding(),
            transition: Transition.cupertinoDialog),
      ],
    );
  }
}
