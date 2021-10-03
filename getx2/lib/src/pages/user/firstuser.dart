import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2/src/home.dart';
import 'package:getx2/src/pages/normal/second.dart';

class FirstUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("first user page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${Get.parameters['uid']}"),
            Text("${Get.parameters['name']}"),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("다음 페이지 이동"),
            ),
          ],
        ),
      ),
    );
  }
}
