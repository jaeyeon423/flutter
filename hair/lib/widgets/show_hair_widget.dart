import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair/controller/day_list_controller.dart';


class showHairWidget extends StatelessWidget {
  showHairWidget({
    Key? key,
  }) : super(key: key);

  DayListController dayListController = Get.put(DayListController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              dayListController.changeIndex(index);
            },
            child: Obx(
                  () => Container(
                width: 80,
                margin: const EdgeInsets.only(left: 20, right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: index == dayListController.selectedDat.value
                      ? Border.all(color: Colors.black87, width: 2, ) : null,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}