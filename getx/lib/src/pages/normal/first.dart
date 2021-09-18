import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'second.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("first page"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (builder) => First()));
                Get.to(() => SecondPage());
              },
              child: Text("next page 라우트"),
            ),
          ],
        ),
      ),
    );
  }
}
