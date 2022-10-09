import 'package:byc/controller/database_controller.dart';
import 'package:byc/firebase_options.dart';
import 'package:byc/navigatior/navigation_bar_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/navigation_bar_page',
      initialBinding: BindingsBuilder(() => Get.put(DatabaseController())),
      getPages: [
        GetPage(name: '/navigation_bar_page', page: () => NavigationBarPage()),
      ],
    );
  }
}
