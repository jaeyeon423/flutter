import 'package:delivery_app/components/room_content.dart';
import 'package:delivery_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RoomList extends StatelessWidget {
  RoomList({required this.category_num});

  final category_num;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: StreamBuilder(
          stream: category_num == 0
              ? FirebaseFirestore.instance.collection('rooms').snapshots()
              : FirebaseFirestore.instance
                  .collection('rooms')
                  .where('category', isEqualTo: category_num)
                  .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            final chatDocs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: chatDocs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                  },
                  child: RoomContent(
                    id: chatDocs[index].id,
                    name: chatDocs[index]['name'],
                    category: chatDocs[index]['category'],
                    people_num: chatDocs[index]['people_num'],
                    delivery_status: chatDocs[index]['delivery_status'],
                    distance: chatDocs[index]['distance'],
                    bank_info: chatDocs[index]['bank_info'],
                    pickup_location: chatDocs[index]['pickup_location'],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
