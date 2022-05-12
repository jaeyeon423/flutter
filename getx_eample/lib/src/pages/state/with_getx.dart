import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_eample/src/controller/count_controller_with_getx.dart';

class WithGetX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("GetX"),
          GetBuilder<CountControllerWithGetX>(builder: (controller){
            return Text("${controller.count}");
          }),
          ElevatedButton(onPressed: () {
            Get.find<CountControllerWithGetX>().increase();
          }, child: Text("+"),),
        ],
      ),
    );
  }
}
