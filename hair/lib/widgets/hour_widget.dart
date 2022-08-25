import 'package:flutter/material.dart';

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
                color: 11 == index ? Colors.white : Colors.black,
              )),
        )
      ],
    );
  }
}
