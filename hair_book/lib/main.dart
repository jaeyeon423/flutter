import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hair_book/navigator/navigation_bar_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          primaryColor: Colors.black,
          primarySwatch: Colors.grey,
          appBarTheme: AppBarTheme(
            color: Colors.red,
          )),
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
