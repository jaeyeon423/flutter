import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_app/pages/list_page.dart';

class RowComponent extends StatelessWidget {
  const RowComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.toNamed('/detail');
            },
            child: Image(
              image: AssetImage('assets/images/first.png'),
              width: 100,
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed('/detail');
            },
            child: Image(
              image: AssetImage('assets/images/first.png'),
              width: 100,
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed('/detail');
            },
            child: Image(
              image: AssetImage('assets/images/first.png'),
              height: 100,
              width: 100,
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed('/detail');
            },
            child: Image(
              image: AssetImage('assets/images/first.png'),
              height: 100,
              width: 100,
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed('/detail');
            },
            child: Image(
              image: AssetImage('assets/images/first.png'),
              height: 100,
              width: 100,
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed('/detail');
            },
            child: Image(
              image: AssetImage('assets/images/first.png'),
              height: 100,
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
