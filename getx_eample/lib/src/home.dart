import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_eample/src/pages/normal/first.dart';

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
                Get.to(() => FirstPage());
              },
              child: Text("일반적인 라우트"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/first');
              },
              child: Text("Named route"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/first', arguments: User(name: "jaeyeon", age:  30));
              },
              child: Text("Named argument route"),
            ),
          ],
        ),
      ),
    );
  }
}

class User{
  String name;
  int age;

  User({required this.name, required this.age});
}