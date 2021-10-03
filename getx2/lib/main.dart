import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2/src/home.dart';
import 'package:getx2/src/pages/named/firstname.dart';
import 'package:getx2/src/pages/named/secondname.dart';
import 'package:getx2/src/pages/next/firstnext.dart';
import 'package:getx2/src/pages/user/firstuser.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: ()=>Home(), transition: Transition.zoom),
        GetPage(name: "/first", page: ()=>FirstNamedPage(), transition: Transition.zoom),
        GetPage(name: "/second", page: ()=>SecondNamedPage(), transition: Transition.zoom),
        GetPage(name: "/next", page: ()=>FirstNextPage(), transition: Transition.zoom),
        GetPage(name: "/user/:uid", page: ()=>FirstUserPage(), transition: Transition.zoom),
      ],
    );
  }
}
