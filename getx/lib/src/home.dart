import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/src/pages/normal/first.dart';
import 'package:getx/src/pages/reactive_state_manage_page.dart';
import 'package:getx/src/pages/simple_state_manage_page.dart';

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
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (builder) => First()));
                Get.toNamed("/next", arguments: User(name: "jykim", age: 30));
              },
              child: Text("arguments 라우트"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (builder) => First()));
                Get.toNamed("/user/123123");
              },
              child: Text("동적 url"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context)
                Get.to(() => SimpleStateManagePage());
              },
              child: Text("단순 상태 관리"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context)
                Get.to(() => ReactiveStateManagePage());
              },
              child: Text("반응형 관리"),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  String name;
  int age;

  User({required this.name, required this.age});
}
