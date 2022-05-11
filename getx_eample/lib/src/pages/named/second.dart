import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_eample/src/home.dart';

class SecondNamedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("second Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Go Back"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed('/');
              },
              child: Text("Go home"),
            ),
          ],
        ),
      ),
    );
  }
}
