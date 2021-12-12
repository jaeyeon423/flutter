import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/src/pages/normal/second.dart';

class FirstNamedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Named Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.offNamed('/second');
              },
              child: Text("Second Page"),
            ),
          ],
        ),
      ),
    );
  }
}
