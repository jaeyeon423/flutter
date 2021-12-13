import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/src/controller/count_controller_with_getx.dart';

class BindingPage extends GetView<CountControllerWithGetX> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Binding Page"),
      ),
      body: Column(
        children: [
          Obx(()=>Text(controller.count.toString())),
          ElevatedButton(
              onPressed: () {
                controller.increase();
              },
              child: Text("")),
        ],
      ),
    );
  }
}
