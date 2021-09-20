import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_app/pages/detail_page.dart';
import 'package:hair_app/pages/home_page.dart';
import 'package:hair_app/pages/list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/category',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/list',
          page: () => ListPage(),
        ),
        GetPage(
          name: '/detail',
          page: () => DetailPage(),
        ),
      ],
    );
  }
}
