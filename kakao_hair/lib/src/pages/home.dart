import 'package:flutter/material.dart';
import 'package:kakao_hair/src/components/icon_button.dart';
import 'package:kakao_hair/src/parts/icon_list.dart';
import 'package:kakao_hair/src/parts/search_list.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey,
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
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.2,
                    child: Text(
                      "   김재연님\n   애매한 길이의 중단발은\n   이렇게 가꿔보세요>",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: size.width * 0.85,
                    height: size.height * 0.27,
                    child: iconList(),
                  ),
                  search_list(size: size),
                ],
              ),
            ),

            Container(color: Colors.yellow, height: size.height * 0.1),
            Container(color: Colors.blue, height: size.height * 0.1),
            Container(color: Colors.purple, height: size.height * 0.4),
            // Expanded(child: Container(color: Colors.black,)),
            // Expanded(child: Container(color: Colors.red,)),
          ],
        ),
      ),
    );
  }
}
