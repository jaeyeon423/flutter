import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_book/control/firebase_controller.dart';
import 'package:hair_book/widget/designer_info_detail.dart';

class DesignerInfoWidget extends StatefulWidget {
  const DesignerInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DesignerInfoWidget> createState() => _DesignerInfoWidgetState();
}

class _DesignerInfoWidgetState extends State<DesignerInfoWidget> {
  FirebaseController ctr = Get.put(FirebaseController());
  CollectionReference product =
      FirebaseFirestore.instance.collection('designer_list');

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
                  () => ListView(
                    children: streamSnapshot.data!.docs
                        .map((DocumentSnapshot document) {
                      print(document['index']);
                      if (ctr.favor_list.contains(document['index'])) {
                        print(ctr.favor_list);
                        return DesignerInfoDetail(
                          document: document,
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
