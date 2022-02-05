import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
    DocumentReference user = FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email);

    user.get().then((value) {
      value.data();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("현재 배달 상태"),
      ),
      body: Center(
        child: Column(
          children: [
          ],
        ),
      ),
    );
  }
}
