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

  _renderContent(context) {
    return Card(
      elevation: 0.0,
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        speed: 1000,
        onFlipDone: (status) {
          print(status);
        },
        front: RoomFront(name:name, category: category, people_num: people_num),
        back: Container(
          height: 170,
          decoration: boxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('가게 이름 : ${name} (${category})'),
              Text('현재 주문 인원 :${people_num}'),
              Text('주문 상태 : ${delivery_status}'),
              Text('식당 거리 : ${distance}'),
              Text('돈 보낼 곳 : ${bank_info}'),
              Text('받을 장소 : ${pickup_location}'),
              DetailScreen(room_id: id,),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      // child: Column(
      //   children: [
      //     Image(
      //       image: AssetImage('images/${category}.png'),
      //       fit: BoxFit.fill,
      //     ),
      //     Expanded(
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             Text(
      //               name,
      //               style: TextStyle(fontSize: 30),
      //             ),
      //             Row(
      //               children: [
      //                 Text('수령받을 장소 : ${pickup_location}'),
      //                 Expanded(child: Container()),
      //                 Text(
      //                   '${people_num}/10',
      //                   style: TextStyle(fontSize: 20),
      //                 ),
      //                 SizedBox(
      //                   width: 10,
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      child: _renderContent(context),
    );
  }
}
