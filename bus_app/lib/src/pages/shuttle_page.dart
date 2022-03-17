import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class ShuttlePage extends StatelessWidget {
  ShuttlePage({Key? key}) : super(key: key);

  List am = [
    [1,  7,  0,   7,  15,  7,  30],
    [2,  7,  15,  7,  30,  7,  45],
    [3,  7,  30,  7,  45,  8,  0],
    [4,  7,  45,  8,  0,   7,  15],
    [5,  8,  0,   8,  15,  8,  30],
    [6,  8,  15,  8,  30,  8,  45],
    [7,  8,  30,  8,  45,  9,  0],
    [8,  8,  45,  9,  0,   9,  15],
    [9,  9,  0,   9,  15,  9,  30],
    [10, 10, 0,   10, 0,   10, 30],
    [11, 11, 0,   11, 0,   11, 30],
    [11, 12, 0,   12, 0,   12, 30],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TimerBuilder.periodic(
          const Duration(minutes: 1),
          builder: (context) {
            int hour = DateTime.now().hour.toInt();
            int minute = DateTime.now().minute.toInt();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30,),
                Text("${hour} : ${minute}", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
                Container(
                  margin: const EdgeInsets.all(30),
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            );
          },
        ),
      ),
    );
  }
}
