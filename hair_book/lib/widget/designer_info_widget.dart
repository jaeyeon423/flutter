import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_book/control/firebase_controller.dart';
import 'package:hair_book/control/navigation_controller.dart';
import 'package:hair_book/view/my_page_view.dart';
import 'package:hair_book/widget/designer_info_detail.dart';

enum PAGE { LIST, BOOK }

class DesignerInfoWidget extends StatelessWidget {
  DesignerInfoWidget({Key? key, required this.cur_page}) : super(key: key);

  PAGE cur_page;

  FirebaseController ctr = Get.put(FirebaseController());

  CollectionReference product =
      FirebaseFirestore.instance.collection('designer_list');

  BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
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
                  () => (ctr.favor_list.length == 0 && cur_page == PAGE.BOOK)
                      ? Center(
                          child: ElevatedButton(
                              child: Text("Add Designer"),
                              onPressed: () {
                                bottomNavigationController.changeIndex(0);
                              }),
                        )
                      : ListView(
                          children: streamSnapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            print(document['index']);
                            if (ctr.favor_list.contains(document['index']) ||
                                cur_page == PAGE.LIST) {
                              print(ctr.favor_list);
                              return DesignerInfoDetail(
                                document: document,
                                favor:
                                    ctr.favor_list.contains(document['index']),
                                index: document['index'],
                              );
                            } else {
                              return Container();
                            }
                          }).toList(),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
