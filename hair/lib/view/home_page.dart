import 'package:flutter/material.dart';
import 'package:hair/widgets/hair_image_widget.dart';
import 'package:hair/widgets/hour_widget.dart';
import 'package:hair/widgets/image_slider_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
            day_list(),
            HairImageWidget(),
            Container(
                height: 170,
                color: Colors.orange,
                child: Center(
                  child: Text("예약 시스템"),
                ))
          ],
        ),
      ),
    );
  }
}
