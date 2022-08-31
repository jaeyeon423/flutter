import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:hair/view/send_to_designer_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Page"),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 100,
            color: Colors.orange,
            child: Center(child: Text("예약 가능 시간 표시")),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => SendToDesignerPage());
            },
            child: Container(
              margin: EdgeInsets.only(top: 10),
              height: 100,
              color: Colors.greenAccent,
              child: Center(child: Text("다음 단계")),
            ),
          ),
        ],
      ),
    );
  }
}
