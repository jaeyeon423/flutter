import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/src/pages/normal/first.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("라우트 관리 홈"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (builder) => First()));
                Get.to(() => FirstPage());
              },
              child: Text("fisrt page 라우트"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (builder) => First()));
                Get.toNamed("/first");
              },
              child: Text("Named 라우트"),
            ),
          ],
        ),
      ),
    );
  }
}
