import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShuttleShowTime extends StatelessWidget {

  ShuttleShowTime({required this.name, required this.index, required this.minute, required this.next_index, required this.next_minute});
  final String name;
  final int index;
  final int minute;
  final int next_index;
  final int next_minute;
  @override
  Widget build(BuildContext context) {
    String next_hour = next_minute > 60 ? "1시간 ${next_minute-60}" : "${next_minute}";
    return Container(
      width: Get.mediaQuery.size.width-50,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(height: 10,),
          Text(name, style: TextStyle(fontSize: 20),),
          SizedBox(height: 10,),
          Text("${minute}분뒤 도착", style: TextStyle(fontSize: 45),),
          if(index > 0)Text("다음 버스 :${next_hour}분 후 도착", style: TextStyle(fontSize: 22),),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
