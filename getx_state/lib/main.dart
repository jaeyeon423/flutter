import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_state/controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("getx"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<Controller>(
                init: Controller(),
                builder: (_) => Text("current value is ${Get.find<Controller>().x}"),
              ),
              ElevatedButton(onPressed: () {
                Get.find<Controller>().increament();
              }, child: Text("add number"))
            ],
          ),
        ),
      ),
    );
  }
}
