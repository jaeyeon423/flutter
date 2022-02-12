import 'package:delivery_app/components/flip_box_decoration.dart';
import 'package:delivery_app/components/room_front.dart';
import 'package:delivery_app/screens/detail_screen.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class RoomContent extends StatelessWidget {
  RoomContent({
    required this.id,
    required this.name,
    required this.category,
    required this.people_num,
    required this.delivery_status,
    required this.distance,
    required this.bank_info,
    required this.pickup_location,
  });

  final String id;
  final String name;
  final int category;
  final int people_num;
  final int delivery_status;
  final double distance;
  final String bank_info;
  final String pickup_location;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 150,
      decoration: boxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
            child: Image(
              image: AssetImage('images/${category}.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
          Column(
            children: [
              Text(
                '${name}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Expanded(child: Container()),
              Text(
                '${people_num} / 20',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
