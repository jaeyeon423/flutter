import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DesignerInfoWidget extends StatefulWidget {
  const DesignerInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DesignerInfoWidget> createState() => _DesignerInfoWidgetState();
}

class _DesignerInfoWidgetState extends State<DesignerInfoWidget> {
  CollectionReference product =
      FirebaseFirestore.instance.collection('designer_list');
  CollectionReference user = FirebaseFirestore.instance.collection('user');
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
                return ListView(
                  children: streamSnapshot.data!.docs
                      .map((DocumentSnapshot document) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      color: Colors.grey.shade100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: 2, bottom: 5, left: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 1),
                                    height: 100,
                                    child: Image(
                                      image: AssetImage(
                                        'assets/images/1.png',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 1),
                                    height: 100,
                                    child: Image(
                                      image: AssetImage(
                                        'assets/images/2.png',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 1),
                                    height: 100,
                                    child: Image(
                                      image: AssetImage(
                                        'assets/images/3.png',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    height: 100,
                                    child: Center(
                                      child: Text(
                                        "···",
                                        style: TextStyle(fontSize: 50),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${document['name']} · ${document['year']}년",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text("${document['shop']}"),
                                    ],
                                  ),
                                ),
                                flex: 4,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    // print(index);
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.star_rate,
                                    ),
                                  ),
                                ),
                                flex: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
