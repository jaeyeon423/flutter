import 'package:delivery_app/components/room_content.dart';
import 'package:delivery_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RoomList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('rooms').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            final chatDocs = snapshot.data!.docs;
            int count = 0;
            chatDocs.forEach((value){
              print(value['category']);
              print(category_num);
              if(value['category'] == category_num){
                print(value['name']);
              }
            });
            return ListView.builder(
              itemCount: chatDocs.length,
              itemBuilder: (context, index) {
                return category_num == chatDocs[index]['category'] ? GestureDetector(
                  onTap: (){
                    Get.toNamed('/detail');
                  },
                  child: RoomContent(
                    id: chatDocs[index].id,
                    name: chatDocs[index]['name'],
                    category: chatDocs[index]['category'],
                    people_num: chatDocs[index]['people_num'],
                    delivery_status: chatDocs[index]['delivery_status'],
                    distance: chatDocs[index]['distance'],
                    bank_info: chatDocs[index]['bank_info'],
                  ),
                ) : category_num == 0 ? GestureDetector(
                  onTap: (){
                    Get.toNamed('/detail');
                  },
                  child: RoomContent(
                    id: chatDocs[index].id,
                    name: chatDocs[index]['name'],
                    category: chatDocs[index]['category'],
                    people_num: chatDocs[index]['people_num'],
                    delivery_status: chatDocs[index]['delivery_status'],
                    distance: chatDocs[index]['distance'],
                    bank_info: chatDocs[index]['bank_info'],
                  ),
                ) : Text('.');
              },
            );
          },
        ),
      ),
    );
  }
}
