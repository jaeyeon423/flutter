import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        dragStartBehavior: DragStartBehavior.down,
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        controller: ScrollController(initialScrollOffset: 1000.0),
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
                  // color: index == dayListController.selectedDat.value
                  //     ? Colors.blueGrey
                  //     : Colors.black12,
                ),
                child: HourlyDetails(
                  index: index,
                  cardIndex: dayListController.selectedDat.value,
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
  int timestamp;
  int cardIndex;
  int index;
  String weatherIcon;

  HourlyDetails(
      {Key? key,
      required this.timestamp,
      required this.index,
      required this.cardIndex,
      required this.weatherIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(height: 10,),
        Container(
          child: Image(image: AssetImage('assets/images/20220822.jpg'), width: 60, height: 60,)
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Text('8/${index + 1}',
              style: TextStyle(
                color: Colors.black,
              )),
        )
      ],
    );
  }
}
