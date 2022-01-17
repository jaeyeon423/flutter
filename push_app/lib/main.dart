import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_app/src/app.dart';
import 'package:push_app/src/controller/notification_controller.dart';

void main() {
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(NotificationController());
      }),
      home: App(),
    );
  }
}
