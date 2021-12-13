import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/src/controller/dependency_controller.dart';

class GetLazy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(
        onPressed: (){
          Get.find<DependencyController>().increase();
        },
        child: Text("button"),
      ),
    );
  }
}
