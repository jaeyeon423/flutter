import 'package:delivery_app/components/icon_content.dart';
import 'package:delivery_app/screens/main_screen.dart';
import 'package:flutter/material.dart';

class FoodCategory extends StatefulWidget {
  @override
  State<FoodCategory> createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.red,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(10, 10),
          )
        ]
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          // children: [
          //   GestureDetector(
          //     onTap: () {
          //       setState(() {
          //         category_num = 0;
          //       });
          //     },
          //     child: Container(
          //       child: IconContent(icon: Icons.android_outlined, label: '전체'),
          //       padding: const EdgeInsets.symmetric(horizontal: 10),
          //     ),
          //   ),
          //   GestureDetector(
          //     onTap: () {
          //       setState(() {
          //         print('한식');
          //         category_num = 1;
          //       });
          //     },
          //     child: Container(
          //       child: IconContent(icon: Icons.android_outlined, label: '한식'),
          //       padding: const EdgeInsets.symmetric(horizontal: 10),
          //     ),
          //   ),
          //   GestureDetector(
          //     onTap: () {
          //       setState(() {
          //         category_num = 2;
          //       });
          //     },
          //     child: Container(
          //       child: IconContent(icon: Icons.android_outlined, label: '치킨'),
          //       padding: const EdgeInsets.symmetric(horizontal: 10),
          //     ),
          //   ),
          //   GestureDetector(
          //     onTap: () {
          //       setState(() {
          //         category_num = 3;
          //       });
          //     },
          //     child: Container(
          //       child: IconContent(icon: Icons.android_outlined, label: '중식'),
          //       padding: const EdgeInsets.symmetric(horizontal: 10),
          //     ),
          //   ),
          //   GestureDetector(
          //     onTap: () {
          //       setState(() {
          //         category_num = 4;
          //       });
          //     },
          //     child: Container(
          //       child: IconContent(icon: Icons.android_outlined, label: '양식'),
          //       padding: const EdgeInsets.symmetric(horizontal: 10),
          //     ),
          //   ),
          //   GestureDetector(
          //     onTap: () {
          //       setState(() {
          //         category_num = 5;
          //       });
          //     },
          //     child: Container(
          //       child: IconContent(icon: Icons.android_outlined, label: '디저트'),
          //       padding: const EdgeInsets.symmetric(horizontal: 10),
          //     ),
          //   ),
          // ],
        ),
      ),
    );
  }
}
