import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hair/view/home_page.dart';
import 'package:hair/view/navigation_bar_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/navigation_bar_page',
      getPages: [
        GetPage(
          name: '/navigation_bar_page',
          page: () => NavigationBarPage(),
        ),
      ],
    );
  }
}
