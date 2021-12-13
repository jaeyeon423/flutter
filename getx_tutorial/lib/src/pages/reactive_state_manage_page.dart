import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/src/controller/count_controller_with_getx.dart';
import 'package:getx_tutorial/src/controller/count_controller_with_provider.dart';
import 'package:getx_tutorial/src/controller/count_controller_with_reactive.dart';
import 'package:getx_tutorial/src/pages/state/with_getx.dart';
import 'package:getx_tutorial/src/pages/state/with_provider.dart';
import 'package:provider/provider.dart';

class ReactiveStateManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(CountControllerWithReactive());
    return Scaffold(
      appBar: AppBar(
        title: Text("반응형 상태 관리"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("GetX", style: TextStyle(fontSize: 20)),
            Obx(() {
              return Text(
                  "${Get.find<CountControllerWithReactive>().count.value}",
                  style: TextStyle(fontSize: 40));
            }),
            ElevatedButton(
              onPressed: () {
                Get.find<CountControllerWithReactive>().increase();
              },
              child: Text(
                "+",
                style: TextStyle(fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.find<CountControllerWithReactive>().putNumber(5);
              },
              child: Text(
                "5로 변경",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
