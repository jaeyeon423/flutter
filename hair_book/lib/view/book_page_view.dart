import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_book/control/firebase_controller.dart';

class BookPageView extends StatelessWidget {
  BookPageView({super.key});

  FirebaseController firebaseController = Get.put(FirebaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("${firebaseController.email?.value}"),
      ),
    );
  }
}
