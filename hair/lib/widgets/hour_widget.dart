import 'package:flutter/material.dart';

class day_list extends StatelessWidget {
  const day_list({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              width: 80,
              margin: const EdgeInsets.only(left: 20, right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: index == 11 ? Colors.blueGrey : Colors.black12,
              ),
              child: HourlyDetails(
                index: index,
                cardIndex: 1,
                temp: 1,
                timestamp: 1,
                weatherIcon: "sun",
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
                color: 11 == index ? Colors.white : Colors.black,
              )),
        )
      ],
    );
  }
}
