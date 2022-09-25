import 'package:byc/firebase_options.dart';
import 'package:byc/view/designer_detail_view.dart';
import 'package:byc/view/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
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
      initialRoute: '/Login_View',
      getPages: [
        GetPage(name: '/Login_View', page: ()=> LoginView()),
      ],
    );
  }
}
