import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2/src/pages/normal/second.dart';

class FirstNamedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("first named page"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Get.toNamed('/second');
            }, child: Text("다음 페이지 이동")),
          ],
        ),
      ),
    );
  }
}
