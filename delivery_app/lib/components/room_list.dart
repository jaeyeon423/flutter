import 'package:delivery_app/components/room_content.dart';
import 'package:flutter/material.dart';


class RoomList extends StatelessWidget {
  const RoomList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            RoomContent(),
            RoomContent(),
            RoomContent(),
            RoomContent(),
            RoomContent(),
          ],
        ),
      ),
    );
  }
}
