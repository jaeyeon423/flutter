import 'package:flutter/material.dart';

class SendToDesignerPage extends StatelessWidget {
  const SendToDesignerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("send to designer "),
      ),
      body: Column(children: [
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
          ),
          height: 300,
          child: Center(child: Text("message")),
        ),
        Container(
          margin: EdgeInsets.all(20),
          height: 100,
          color: Colors.purple,
          child: Center(child: Text("예약 완료")),
        ),
      ]),
    );
  }
}
