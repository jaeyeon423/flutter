import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/src/controller/count_controller_with_getx.dart';

class WithGetX extends StatelessWidget {
  const WithGetX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "GetX",
            style: TextStyle(fontSize: 50),
          ),
          GetBuilder<CountControllerWithGetX>(
              id: "first",
              builder: (controller) {
                return Text(
                  "${controller.count}",
                  style: TextStyle(fontSize: 30),
                );
              }),
          ElevatedButton(
              onPressed: () {
                Get.find<CountControllerWithGetX>().increase();
              },
              child: Text(
                "+",
              ))
        ],
      ),
    );
  }
}
