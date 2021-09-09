import 'package:corona_copy/src/canvas/arrow_clip_path.dart';
import 'package:corona_copy/src/controller/covid_statistics_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends GetView<CovidStatisticsController> {
  late double headerTopZone;

  Widget infoWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            " : $value",
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    headerTopZone = Get.mediaQuery.padding.top + AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        elevation: 0,
        title: Text(
          "corona 현황",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff3c727c), Color(0xff285861)])),
          ),
          Positioned(
            left: -110,
            top: headerTopZone + 40,
            child: Container(
              child: Image.asset('images/covid_img.png'),
              width: Get.size.width * 0.7,
            ),
          ),
          Positioned(
            top: headerTopZone + 10,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xff195f68)),
                child: Text(
                  '07.24 00L00 기준',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: headerTopZone + 60,
            right: 50,
            child: Column(
              children: [
                Text('확진자', style: TextStyle(color: Colors.white, fontSize: 18),),
                SizedBox(height: 5,),
                Row(
                  children: [
                    ClipPath(
                      child: Container(
                        width: 20,
                        height: 20,
                        color: Colors.orange,
                      ),
                      clipper: ArrowClipPath(),
                    ),
                    Text('1,629',style: TextStyle(color: Colors.redAccent, fontSize: 30, fontWeight: FontWeight.bold),),
                  ],
                ),
                Text('187,362', style: TextStyle(color: Colors.white, fontSize: 18),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
