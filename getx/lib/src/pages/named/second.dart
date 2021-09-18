import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/src/home.dart';


class SecondNamedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("second Named  page"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (builder) => First()));
                Get.back();
              },
              child: Text("뒤로 이동 라우트"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (builder) => First()));
                Get.offAllNamed('/');
              },
              child: Text("home 라우트"),
            ),
          ],
        ),
      ),
    );
  }
}
