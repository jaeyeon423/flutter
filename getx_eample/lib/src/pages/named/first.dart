import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_eample/src/home.dart';
import 'package:getx_eample/src/pages/named/second.dart';

class FirstNamedPage extends StatelessWidget {
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
            Text("${(Get.arguments as User).age}"),
            ElevatedButton(
                onPressed: () {
                  // Get.to(()=>SecondPage());
                  Get.offNamed('/second');
                },
                child: Text("Go to Second Page")),
          ],
        ),
      ),
    );
  }
}
