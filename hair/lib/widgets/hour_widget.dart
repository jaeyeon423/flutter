import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:hair/controller/day_list_controller.dart';

class day_list extends StatelessWidget {
  day_list({
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
                  color: index == dayListController.selectedDat.value
                      ? Colors.blueGrey
                      : Colors.black12,
                ),
                child: HourlyDetails(
                  index: index,
                  cardIndex: dayListController.selectedDat.value,
                  temp: 1,
                  timestamp: 1,
                  weatherIcon: "sun",
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  int temp;
  int timestamp;
  int cardIndex;
  int index;
  String weatherIcon;

  HourlyDetails(
      {Key? key,
      required this.timestamp,
      required this.temp,
      required this.index,
      required this.cardIndex,
      required this.weatherIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
        ),
        Container(
          child: Icon(
            Icons.face,
            size: 50,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Text('8/${index + 1}',
              style: TextStyle(
                color: cardIndex == index ? Colors.white : Colors.black,
              )),
        )
      ],
    );
  }
}
