import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2/src/controller/count_controller_with_getx.dart';

class WithGetX extends StatelessWidget {

  CountControllerWithGetX _countControllerWithGetX = Get.put(CountControllerWithGetX());

  Widget _button(String id){
    return ElevatedButton(
      onPressed: () {
        _countControllerWithGetX.increase(id);
      },
      child: Text(
        "+",
        style: TextStyle(fontSize: 50),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "GetX",
            style: TextStyle(fontSize: 50),
          ),
          GetBuilder<CountControllerWithGetX>(id: "first", builder: (controller) {
            return Text(
              "${controller.count}",
              style: TextStyle(fontSize: 50),
            );
          }),
          GetBuilder<CountControllerWithGetX>(id: "second",builder: (controller) {
            return Text(
              "${controller.count}",
              style: TextStyle(fontSize: 50),
            );
          }),
          _button("first"),
          _button("second"),
        ],
      ),
    );
  }
}
