import 'package:bus_app/src/components/shuttle_show_time.dart';
import 'package:bus_app/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_builder/timer_builder.dart';


class ShuttlePage extends StatelessWidget {
  const ShuttlePage({Key? key}) : super(key: key);

  List _calculate(List bus){
    List cur = [];
    for(int i = 0 ; i < bus.length-1 ; i++){
      List tmp = bus[i];

      DateTime now = DateTime.now();
      DateTime tmp_time= DateTime(now.year, now.month, now.day, tmp[0], tmp[1]);
      Duration diff = tmp_time.difference(now);

      DateTime tmp_time2= DateTime(now.year, now.month, now.day, bus[i+1][0], bus[i][1]);
      Duration diff2 = tmp_time2.difference(now);
      if(diff.inHours >= 0 && diff.inMinutes >= 0){
        cur.add(i);
        cur.add(diff.inMinutes);
        cur.add(i+1);
        cur.add(diff2.inMinutes);

        break;
      }
    }
    if(cur.length == 0){
      cur.add(-1);
      cur.add(-1);
      cur.add(-1);
      cur.add(-1);
    }
    return cur;
  }

  Widget _currnetTime(int hour, int minute){
    return Container(
      child: Center(
        child: Text("${hour} : ${minute}", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TimerBuilder.periodic(
          const Duration(minutes: 1),
          builder: (context) {
            final current = DateTime.now();
            int hour = DateTime.now().hour.toInt();
            int minute = DateTime.now().minute.toInt();

            List cur = _calculate(Pangyo);
            List cur2 = _calculate(Godng);
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 10,),
                _currnetTime(hour, minute),
                ShuttleShowTime(name: "판교 -> 고등", index: cur[0], minute: cur[1], next_index: cur[2], next_minute: cur[3]),
                ShuttleShowTime(name: "고등 -> 판교", index: cur2[0], minute: cur2[1], next_index: cur2[2], next_minute: cur2[3]),
              ],
            );
          },
        ),
      ),
    );
  }
}
