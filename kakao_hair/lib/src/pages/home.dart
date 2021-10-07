import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakao_hair/src/components/icon_button.dart';
import 'package:kakao_hair/src/constants.dart';
import 'package:kakao_hair/src/parts/icon_list.dart';
import 'package:kakao_hair/src/parts/search_list.dart';
import 'package:kakao_hair/src/parts/top.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none),
            color: Colors.black,
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Top(),
            Container(
              height: size.height * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "매탄동 추천",
                        style: kBodyTextStyle,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "스타일 추천",
                        style: kBodyTextStyle,
                      ),
                    ],
                  ),
                  Container(color: Colors.white,height: 4, width: 180,)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: size.height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "다른 지역을 추천해드릴까요?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "지역 변경",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(color: Colors.white, height: size.height * 0.4),
            ),
            // Expanded(child: Container(color: Colors.black,)),
            // Expanded(child: Container(color: Colors.red,)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈" ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "내주변" ),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "스타일북" ),

        ],
      ),
    );
  }
}
