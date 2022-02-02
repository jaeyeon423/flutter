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
  });

  final String id;
  final String name;
  final int category;
  final int people_num;
  final int delivery_status;
  final double distance;
  final String bank_info;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.4),
          borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(10),
      height: 100,
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: 100,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(name),
                Text('정원 : ${people_num}/10'),
                Text('거리 : ${distance}km'),
                Text('예상시간 :20-30분'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
