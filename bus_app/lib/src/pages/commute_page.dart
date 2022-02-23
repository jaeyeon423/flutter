import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class CommutePage extends StatelessWidget {
  const CommutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TimerBuilder.periodic(
          const Duration(minutes: 1),
          builder: (context) {
            int hour = DateTime.now().hour.toInt();
            int minute = DateTime.now().minute.toInt();
            return Text("${hour} : ${minute}");
          },
        ),
      ),
    );
  }
}
