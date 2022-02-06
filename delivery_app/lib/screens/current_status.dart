import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentStatus extends StatefulWidget {
  @override
  State<CurrentStatus> createState() => _CurrentStatusState();
}

class _CurrentStatusState extends State<CurrentStatus> {

  String currnet_room_id = '';
  int delivery_status = 0;
  String name = '';

  _get_user_into() async{
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(documentSnapshot['current_room']);
        print(documentSnapshot['delivery_status']);
        currnet_room_id = documentSnapshot['current_room'];
        delivery_status = documentSnapshot['delivery_status'];
      }
    });
  }

  _get_room_info() async{
    await FirebaseFirestore.instance
        .collection('rooms')
        .doc(currnet_room_id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(documentSnapshot['name']);
      }
    });
  }

  void tmp() async{
    print('first');
    await _get_user_into();
    print('second');
    await _get_room_info();
    print('third');
    await _get_current_name();
    setState(() {

    });
  }

  @override
  void initState(){

  tmp();
    // TODO: implement initState
    super.initState();
  }

  _get_current_name() async{

    await FirebaseFirestore.instance.collection('rooms').doc(currnet_room_id).get().then((DocumentSnapshot documentSnapshot) {
      name = documentSnapshot['name'];
    });
  }

  Widget _show_status(){
    if(delivery_status == 0){
      return Container(
        child: CircularProgressIndicator(),
      );
    }else{
      print(name);
      return Container(
        child: Text(name),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("현재 배달 상태"),
      ),
      body: Center(
        child: _show_status(),
      ),
    );
  }
}
