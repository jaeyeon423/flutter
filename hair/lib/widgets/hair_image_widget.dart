import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hair/controller/day_list_controller.dart';

class HairImageWidget extends GetView<DayListController> {
  const HairImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.red,
      child: Obx(
        () => Image(
          image:
              AssetImage('assets/images/${controller.selectedDat.value}.jpg'),
        ),
      ),
    );
  }
}
