import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2/src/controller/count_controller_with_getx.dart';
import 'package:getx2/src/controller/count_controller_with_provider.dart';
import 'package:getx2/src/controller/count_controller_with_reactive.dart';
import 'package:getx2/src/pages/state/with_getx.dart';
import 'package:getx2/src/pages/state/with_provider.dart';
import 'package:provider/provider.dart';

class ReactStateManagePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Get.put(CountControllerWithReactive());
    return Scaffold(
      appBar: AppBar(
        title: Text("simple state manage page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "GetX",
              style: TextStyle(fontSize: 50),
            ),
            Obx(
              () => Text(
                "${Get.find<CountControllerWithReactive>().count.value}",
                style: TextStyle(fontSize: 50),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.find<CountControllerWithReactive>().increase();
              },
              child: Text(
                "+",
                style: TextStyle(fontSize: 50),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.find<CountControllerWithReactive>().putNumber(5);
              },
              child: Text(
                "5로 변경",
                style: TextStyle(fontSize: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
