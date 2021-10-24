import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uidesign03/page/home_page.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
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
