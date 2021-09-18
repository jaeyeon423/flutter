import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'second.dart';

class FirstNamedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("first Named page"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (builder) => First()));
                Get.toNamed('/second');
              },
              child: Text("next page 라우트"),
            ),
          ],
        ),
      ),
    );
  }
}
