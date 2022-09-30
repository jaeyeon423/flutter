import 'package:farm/controller/info_controller.dart';
import 'package:farm/navigator/navigation_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/navigation_bar_page',
      initialBinding: BindingsBuilder(() {
        Get.put(InfoController());
      }),
      getPages: [
        GetPage(
          name: '/navigation_bar_page',
          page: () => NavigationBarPage(),
        ),
      ],
    );
  }
}
