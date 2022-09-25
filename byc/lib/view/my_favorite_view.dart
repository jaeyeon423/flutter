import 'package:byc/controller/firebase_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyFavoriteView extends StatelessWidget {
  MyFavoriteView({Key? key}) : super(key: key);

  FirebaseController firebaseController = Get.put(FirebaseController());

  @override
  Widget build(BuildContext context) {
    String? mail = "";
    if(firebaseController.email?.value != null){
      mail = firebaseController.email?.value;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("MyFavoriteView"),
      ),
      body: Center(
        child: Text(mail != null ? mail : ""),
      ),
    );
  }
}
