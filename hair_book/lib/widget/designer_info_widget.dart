import 'package:cloud_firestore/cloud_firestore.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: StreamBuilder(
        stream: product.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  color: Colors.grey.shade100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 2, bottom: 5, left: 2),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${documentSnapshot['name']} · ${documentSnapshot['year']}년",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("${documentSnapshot['shop']}"),
                                ],
                              ),
                            ),
                            flex: 4,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                print(index);
                              },
                              child: Center(
                                child: Icon(Icons.star_border),
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Center(
            child: Container(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
