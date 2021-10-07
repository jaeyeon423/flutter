import 'package:flutter/material.dart';
import 'package:kakao_hair/src/parts/icon_list.dart';
import 'package:kakao_hair/src/parts/search_list.dart';


class Top extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
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
    );
  }
}
