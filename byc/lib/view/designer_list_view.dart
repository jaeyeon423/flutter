import 'package:byc/controller/bottom_navigation_bar_controller.dart';
import 'package:byc/model/designer_info_model.dart';
import 'package:byc/widget/disigner_summary_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignerListView extends StatelessWidget {
  DesignerListView({Key? key}) : super(key: key);

  CollectionReference product =
      FirebaseFirestore.instance.collection('designer_list');

  BottomNavigationBarController bottomNavigationController =
      Get.put(BottomNavigationBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DesignerListView",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder<QuerySnapshot>(
            stream: product.snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasError) {
                return Center(child: Text('서버에 문제가 생겼습니다.'));
              }
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text("Loading"));
              }
              return ListView(
                children:
                    streamSnapshot.data!.docs.map((DocumentSnapshot document) {
                  DesignerInfoModel designerInfoModel = DesignerInfoModel(
                    index: document['index'],
                    name: document['name'],
                    shop: document['shop'],
                    year: document['year'],
                  );
                  return DesignerSummaryWidget(
                      designerInfoModel: designerInfoModel);
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
