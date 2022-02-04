import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({required this.room_id});
  final String room_id;

  Future<bool> getUserInfo() async {
    bool can_order = false;
    DocumentReference user = FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email);

    await user.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot['delivery_status'] == 0) {
          can_order = true;
          print('order start');
          // user.update({
          //   'delivery_status' : 1,
          // });
        } else {
          print('can not order');
        }
      } else {
        print('Document does not exist on the database');
      }
    });
    return can_order;
  }

  Future<void> setRoomInfo(bool can_order, String id) async {
    if (can_order) {
      print('order processing');
      print(room_id);
      DocumentReference room =
          FirebaseFirestore.instance.collection('rooms').doc(id);

      await room.get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print('Document data: ${documentSnapshot['people_num']}');
          room.update({'people_num': documentSnapshot['people_num'] + 1});
        } else {
          print('Document does not exist on the database');
        }
      });
    }
  }

  void _order(String id) async {
    bool can_order = await getUserInfo();
    await setRoomInfo(can_order, id);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('참여하기'),
      onPressed: () {
        _order(room_id);
      },
    );
  }
}
