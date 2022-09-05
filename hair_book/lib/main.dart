import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hair_book/navigator/navigation_bar_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hair_book/view/login_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          primaryColor: Colors.black,
          primarySwatch: Colors.lightBlue,
          appBarTheme: AppBarTheme(
            color: Colors.red,
          )),
      initialRoute: '/navigation_bar_page',
      getPages: [
        GetPage(
          name: '/navigation_bar_page',
          page: () => LoginView(),
        ),
      ],
    );
  }
}
