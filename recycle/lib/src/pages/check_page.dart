import 'package:flutter/material.dart';

class CheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Page"),
      ),
      body: Center(
        child: Text("서버 연결 & 제출된 양식 불러오기"),
      ),
    );
  }
}
