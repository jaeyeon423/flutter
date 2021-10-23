import 'package:flutter/material.dart';
import 'package:uidesign03/core/color.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      margin: EdgeInsets.only(top: 50.0),
      height: 40.0,
      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.menu),
          Expanded(child: Container()),
          Text("목동", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          Icon(Icons.keyboard_arrow_down_outlined)

        ],
      ),
    );
  }
}
