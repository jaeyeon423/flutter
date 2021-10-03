import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2/src/home.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("second page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("뒤로 이동"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.offAll(()=>Home());
              },
              child: Text("홈으로 이동"),
            ),
          ],
        ),
      ),
    );
  }
}
