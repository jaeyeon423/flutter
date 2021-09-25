import 'package:flutter/material.dart';

class CircleNumber extends StatelessWidget {

  CircleNumber({required this.num, required this.vis});

  final String num;
  final bool vis;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: vis,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.grey),
          child: Text(
            num,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
