import 'package:flutter/material.dart';
import 'package:hair/view/booking_page.dart';
import 'package:hair/widgets/hair_image_widget.dart';
import 'package:hair/widgets/thumbnail_list_widget.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            ThumbNailList(),
            HairImageWidget(),
            Container(
              height: 75,
              color: Colors.orange,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => BookingPage());
                },
                child: Center(
                  child: Text("예약 시스템"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
