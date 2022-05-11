import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_eample/src/home.dart';
import 'package:getx_eample/src/pages/named/first.dart';
import 'package:getx_eample/src/pages/named/second.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => Home(),
        '/first' : (context) => FirstNamedPage(),
      },
      getPages: [
        GetPage(name: '/', page: ()=>Home()),
        GetPage(name: '/first', page: ()=>FirstNamedPage()),
        GetPage(name: '/second', page: ()=>SecondNamedPage()),
      ],
    );
  }
}
