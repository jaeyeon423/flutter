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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white, padding: EdgeInsets.all(0)),
            onPressed: () {
              Get.toNamed('/detail');
            },
            child: Image(
              image: AssetImage('assets/images/first.png'),
              height: 100,
              width: 100,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white, padding: EdgeInsets.all(0)),
            onPressed: () {},
            child: Image(
              image: AssetImage('assets/images/first.png'),
              height: 100,
              width: 100,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white, padding: EdgeInsets.all(0)),
            onPressed: () {},
            child: Image(
              image: AssetImage('assets/images/first.png'),
              height: 100,
              width: 100,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white, padding: EdgeInsets.all(0)),
            onPressed: () {},
            child: Image(
              image: AssetImage('assets/images/first.png'),
              height: 100,
              width: 100,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white, padding: EdgeInsets.all(0)),
            onPressed: () {},
            child: Image(
              image: AssetImage('assets/images/first.png'),
              height: 100,
              width: 100,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white, padding: EdgeInsets.all(0)),
            onPressed: () {},
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
