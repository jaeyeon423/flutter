import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hair/view/navigation_bar_page.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

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
