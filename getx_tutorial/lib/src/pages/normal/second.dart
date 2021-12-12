import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/src/home.dart';

import 'first.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Previous Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.offAll(Home());
              },
              child: Text("Home Page"),
            ),
          ],
        ),
      ),
    );
  }
}
