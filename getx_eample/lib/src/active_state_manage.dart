import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_eample/src/controller/count_controller_with_getx.dart';
import 'package:getx_eample/src/controller/count_controller_with_reactive.dart';

class ActiveStateManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(CountControllerWithReactive());
    return Scaffold(
      appBar: AppBar(
        title: Text("active state manage ge"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("GetX"),
            Obx(() {
              return Text("${Get
                  .find<CountControllerWithReactive>()
                  .count}");
            }),
            ElevatedButton(onPressed: () {
              Get.find<CountControllerWithReactive>().increase();
            }, child: Text("+"),),
            ElevatedButton(onPressed: () {
              Get.find<CountControllerWithReactive>().putNumber(5);
            }, child: Text("change 5"),),
          ],
        ),
      ),
    );
  }
}
