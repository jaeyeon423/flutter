import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/src/pages/dependencys/dependency_manage_page.dart';
import 'package:getx_tutorial/src/pages/normal/first.dart';
import 'package:getx_tutorial/src/pages/reactive_state_manage_page.dart';
import 'package:getx_tutorial/src/pages/simple_state_manage_page.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("라우트 관리 home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (_) => FirstPage()));
                Get.to(FirstPage());
              },
              child: Text("일반적인 라우트"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed("/first");
              },
              child: Text("Named 라우트"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed("/next", arguments: User(name: "jaeyeon", age: 30));
              },
              child: Text("Argument 전달"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed("/user/1992?name=jaeyeon&age=30");
              },
              child: Text("동적 url"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(SimpleStateManagePage());
              },
              child: Text("단순 상태관리"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(ReactiveStateManagePage());
              },
              child: Text("반응형 상태관리"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(ReactiveStateManagePage());
              },
              child: Text("반응형 상태관리"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(DependencyManagePage());
              },
              child: Text("의존성 관리"),
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
