import 'package:byc/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/navigation_bar_page',
      getPages: [
        GetPage(name: '/navigation_bar_page', page: () =>   LoginView()),
      ],
    );
  }
}
