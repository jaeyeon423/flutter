import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/src/home.dart';

import 'first.dart';

class SecondNamedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Named Page"),
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
                Get.offAllNamed('/home');
              },
              child: Text("Home Page"),
            ),
          ],
        ),
      ),
    );
  }
}
