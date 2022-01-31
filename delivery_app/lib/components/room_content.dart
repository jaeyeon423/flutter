import 'package:flutter/material.dart';


class RoomContent extends StatelessWidget {
  const RoomContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.4),
          borderRadius: BorderRadius.circular(15)
      ),
      margin: const EdgeInsets.all(10),
      height: 100,
      child: Row(
        children: [
          Icon(Icons.circle, size: 100,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('음식점 이름'),
                Text('정원 : 3/10'),
                Text('거리 : 1.0km'),
                Text('예상시간 :20-30분'),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
