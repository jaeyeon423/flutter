import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2/src/controller/dependency_controller.dart';

class GetPut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("get put"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              Get.find<DependencyController>().increase();
            }, child: Text("ddd"))
          ],
        ),
      ),
    );
  }
}
