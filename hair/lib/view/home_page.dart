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
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => BookingPage());
                      },
                      child: Center(
                        child: Text("선택된 사진으로 예약 진행하기"),
                      ),
                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.blue,
                      child: Center(child: Text("다른 사진 고르기")),
                    ),
                    flex: 1,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
