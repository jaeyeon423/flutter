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
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            spreadRadius: 0.1,
            blurRadius: 3,
            offset: Offset(1.5, 1.5),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 350,
      child: Column(
        children: [
          Image(
            image: AssetImage('images/${category}.png'),
            fit: BoxFit.fill,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 30),
                  ),
                  Row(
                    children: [
                      Text('수령받을 장소 : ${pickup_location}'),
                      Expanded(child: Container()),
                      Text(
                        '${people_num}/10',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
