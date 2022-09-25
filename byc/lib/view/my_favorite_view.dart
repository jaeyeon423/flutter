import 'package:byc/controller/bottom_navigation_bar_controller.dart';
import 'package:byc/controller/firebase_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyFavoriteView extends GetView<FirebaseController> {
  MyFavoriteView({Key? key}) : super(key: key);

  FirebaseController ctr = Get.put(FirebaseController());

  CollectionReference product =
      FirebaseFirestore.instance.collection('designer_list');

  BottomNavigationBarController bottomNavigationController =
  Get.put(BottomNavigationBarController());

  @override
  Widget build(BuildContext context) {
    String? mail = "";
    if (controller.email?.value != null) {
      mail = controller.email?.value;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("MyFavoriteView"),
      ),
      body: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.red,
        child: StreamBuilder<QuerySnapshot>(
          stream: product.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasError) {
              return Text('Something went wrong');
            }
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return Obx(
              () => controller.favor_list.length == 0 ? Center(
                child: ElevatedButton(
                  child: Text("Add Designer"),
                  onPressed: (){
                    bottomNavigationController.changeIndex(0);
                  },
                ),
              ) : ListView(
                children: streamSnapshot.data!.docs.map((DocumentSnapshot document){
                  if(controller.favor_list.contains(document['index']))
                  {
                    return Container(
                      height: 100,
                      margin: EdgeInsets.all(20),
                      color: Colors.blue,
                    );
                  }
                  return Container(
                  );
                }).toList(),
              )
            );
          },
        ),
      )),
    );
  }
}
