import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2/src/controller/count_controller_with_getx.dart';

class BindingPage extends GetView<CountControllerWithGetX> {
  @override
  Widget build(BuildContext context) {
    Get.put(CountControllerWithGetX());
    return Scaffold(
      appBar: AppBar(
        title: Text("binding"),
      ),
      body: Center(
        child: Column(
          children: [
            GetBuilder<CountControllerWithGetX>(id: "first", builder: (controller) {
              return Text(
                "${controller.count}",
                style: TextStyle(fontSize: 50),
              );
            }),
            Obx(()=>Text(controller.tmp.value.toString())),
            ElevatedButton(
                onPressed: () {
                  controller.obxincrease();
                },
                child: Text("---")),
          ],
        ),
      ),
    );
  }
}
