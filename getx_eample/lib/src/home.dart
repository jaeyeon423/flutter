import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_eample/src/active_state_manage.dart';
import 'package:getx_eample/src/pages/normal/first.dart';
import 'package:getx_eample/src/simple_state_manage.dart';

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
            ElevatedButton(
              onPressed: () {
                Get.to(()=>SimpleStateManagePage());
              },
              child: Text("단순 상태 관리"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(()=>ActiveStateManagePage());
              },
              child: Text("반응형 상태 관리"),
            )
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