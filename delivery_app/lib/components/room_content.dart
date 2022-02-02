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
      height: 80,
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            child: Center(child: Text('image')),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(name, style: TextStyle(fontSize: 30),),
                Row(
                  children: [
                    Expanded(child: Container()),
                    Text('${people_num}/10' , style: TextStyle(fontSize: 20),),
                    SizedBox(width: 10,),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
