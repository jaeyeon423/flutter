import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uidesign03/page/designer_page.dart';
import 'package:uidesign03/page/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: "/" ,
      getPages: [
        GetPage(name: "/", page: ()=> HomePage()),
      ],
    );
  }
}
