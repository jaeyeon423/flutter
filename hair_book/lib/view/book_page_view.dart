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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${firebaseController.email?.value}"),
            ElevatedButton(
                onPressed: () {
                  print("${firebaseController.favor_list}");
                },
                child: Text("print"))
          ],
        ),
      ),
    );
  }
}
