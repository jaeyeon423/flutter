import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/src/controller/count_controller_with_getx.dart';

class BindingPage extends GetView<CountControllerWithGetX> {
  const BindingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CountControllerWithGetX());
    return Scaffold(
      appBar: AppBar(
        title: Text("binding page"),
      ),
      body: Column(
        children: [
          Obx(()=> Text(controller.count.toString())),
          GetBuilder<CountControllerWithGetX>(
            builder: (_) {
              return Text(_.count.toString());
            },
          ),
          ElevatedButton(
              onPressed: () {
                controller.increase();
              },
              child: Text("tmp"))
        ],
      ),
    );
  }
}
