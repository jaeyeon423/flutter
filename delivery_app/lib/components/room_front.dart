import 'package:delivery_app/components/flip_box_decoration.dart';
import 'package:flutter/material.dart';

class RoomFront extends StatelessWidget {
  RoomFront({required this.name, required this.category, required this.people_num});

  final String name;
  final int category;
  final int people_num;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: boxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
            child: Image(
              image: AssetImage('images/${category}.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
          Column(
            children: [
              Text('${name}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Expanded(child: Container()),
              Text('${people_num} / 20', style: TextStyle(fontSize: 20),),
              SizedBox(height: 15,),
            ],
          ),
          SizedBox(width: 10,),
        ],
      ),
    );
  }
}
