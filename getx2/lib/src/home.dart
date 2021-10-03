import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2/src/pages/normal/first.dart';
import 'package:getx2/src/pages/state/simage_state_manage_page.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("라우트 관리 홈1"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (_) => FirstPage()));
                Get.to(() => FirstPage());
              },
              child: Text("일반적인 라우트"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (_) => FirstPage()));
                Get.toNamed('/first');
              },
              child: Text("Named 라우트"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (_) => FirstPage()));
                Get.toNamed('/next', arguments: User(user: "jaeyeon", age: 30));
              },
              child: Text("argument 전달 라우트"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (_) => FirstPage()));
                Get.toNamed('/user/123123?name=jaeyeon');
              },
              child: Text("동적 url 라우트"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (_) => FirstPage()));
                Get.to(()=>SimpleStateManagePage());
              },
              child: Text("단순 상태 관리"),
            ),
          ],
        ),
      ),
    );
  }
}

class User{
  String user;
  int age;
  User({required this.user, required this.age });


}