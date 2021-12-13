import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/src/controller/count_controller_with_getx.dart';
import 'package:getx_tutorial/src/controller/dependency_controller.dart';
import 'package:getx_tutorial/src/home.dart';
import 'package:getx_tutorial/src/pages/binding.dart';
import 'package:getx_tutorial/src/pages/bindings/binding_page.dart';
import 'package:getx_tutorial/src/pages/named/first.dart';
import 'package:getx_tutorial/src/pages/named/second.dart';
import 'package:getx_tutorial/src/pages/next.dart';
import 'package:getx_tutorial/src/pages/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => Home()),
        GetPage(
            name: "/first",
            page: () => FirstNamedPage(),
            transition: Transition.native),
        GetPage(name: "/second", page: () => SecondNamedPage()),
        GetPage(name: "/next", page: () => NextPage()),
        GetPage(name: "/user/:uid", page: () => UserPage()),
        GetPage(
          name: "/binding",
          page: () => BindingPage(),
          binding: BindingPageBinding(),
        ),
      ],
    );
  }
}
