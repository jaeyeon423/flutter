import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("recycle sample app"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              color: Colors.lightGreen,
              child: Text("image"),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/submit');
              },
              child: Text("텀블러 제출"),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(240, 40),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/check');
              },
              child: Text("텀블러 제출 조회"),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(240, 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
