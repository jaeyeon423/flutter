import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/src/controller/count_controller_with_getx.dart';

class WithGetX extends StatelessWidget {
  CountControllerWithGetX _controllerWithGetX =
      Get.put(CountControllerWithGetX());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("GetX", style: TextStyle(fontSize: 20)),
          GetBuilder<CountControllerWithGetX>(
            builder: (controller) {
              return Text("${controller.count}",
                  style: TextStyle(fontSize: 40));
            },
            id: "first",
          ),
          GetBuilder<CountControllerWithGetX>(
            builder: (controller) {
              return Text("${controller.count}",
                  style: TextStyle(fontSize: 40));
            },
            id: "second",
          ),
          ElevatedButton(
            onPressed: () {
              _controllerWithGetX.increase();
            },
            child: Text(
              "+",
              style: TextStyle(fontSize: 30),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _controllerWithGetX.increase();
            },
            child: Text(
              "+",
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
