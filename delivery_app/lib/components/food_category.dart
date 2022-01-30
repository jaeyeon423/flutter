import 'package:delivery_app/components/icon_content.dart';
import 'package:flutter/material.dart';

class FoodCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: 400,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              child: IconContent(icon: Icons.android_outlined, label: '전체'),
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Container(
              child: IconContent(icon: Icons.android_outlined, label: '한식'),
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Container(
              child: IconContent(icon: Icons.android_outlined, label: '치킨'),
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Container(
              child: IconContent(icon: Icons.android_outlined, label: '분식'),
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Container(
              child: IconContent(icon: Icons.android_outlined, label: '중식'),
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Container(
              child: IconContent(icon: Icons.android_outlined, label: '디저트'),
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Container(
              child: IconContent(icon: Icons.android_outlined, label: 'menu7'),
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Container(
              child: IconContent(icon: Icons.android_outlined, label: 'menu8'),
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
          ],
        ),
      ),
    );
  }
}
