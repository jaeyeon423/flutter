import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recycle/src/home.dart';
import 'package:recycle/src/pages/check_page.dart';
import 'package:recycle/src/pages/submit_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: ()=> Home()),
        GetPage(name: '/submit', page: ()=> SubmitPage()),
        GetPage(name: '/check', page: ()=> CheckPage()),
      ],
    );
  }
}
