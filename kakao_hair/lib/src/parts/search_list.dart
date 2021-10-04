
import 'package:flutter/material.dart';

class search_list extends StatelessWidget {
  const search_list({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade300
      ),
      margin: EdgeInsets.only(bottom: 20),
      width: size.width * 0.9,
      height: size.height * 0.07,
      child: TextField(
        style: TextStyle(color: Colors.grey),
        decoration: InputDecoration(
            hoverColor: Colors.white,
            hintText: "       지역, 매장, 스타일을 검색하세요"
        ),
      ),
    );
  }
}