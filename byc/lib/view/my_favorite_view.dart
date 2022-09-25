import 'package:byc/controller/bottom_navigation_bar_controller.dart';
import 'package:byc/controller/firebase_controller.dart';
import 'package:byc/model/designer_info_model.dart';
import 'package:byc/widget/disigner_summary_widget.dart';
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
              return Obx(
                () => controller.favor_list.length == 0
                    ? Center(
                        child: ElevatedButton(
                          child: Text("Add Designer"),
                          onPressed: () {
                            bottomNavigationController.changeIndex(0);
                          },
                        ),
                      )
                    : ListView(
                        children: streamSnapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          if (controller.favor_list
                              .contains(document['index'])) {
                            DesignerInfoModel designerInfoModel =
                                DesignerInfoModel(
                              index: document['index'],
                              name: document['name'],
                              shop: document['shop'],
                              year: document['year'],
                            );
                            return DesignerSummaryWidget(
                              designerInfoModel: designerInfoModel,
                            );
                          }
                          return Container();
                        }).toList(),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
