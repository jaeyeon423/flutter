import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_eample/src/pages/normal/second.dart';

class FirstPage extends StatelessWidget {
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
                  Get.to(()=>SecondPage());
                },
                child: Text("Go to Second Page")),
          ],
        ),
      ),
    );
  }
}
