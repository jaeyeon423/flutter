import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/src/home.dart';


class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("user Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${Get.parameters['uid']}" ),
            Text("${Get.parameters['name']}" ),
            Text("${Get.parameters['age']}" ),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Previous Page"),
            ),
          ],
        ),
      ),
    );
  }
}
