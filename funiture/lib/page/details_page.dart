import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uidesign03/core/color.dart';
import 'package:uidesign03/core/space.dart';
import 'package:uidesign03/core/text_style.dart';
import 'package:uidesign03/model/model.dart';
import 'package:uidesign03/page/designer_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsPage extends StatefulWidget {
  final Model model;
  const DetailsPage({Key? key, required this.model}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int selectIndex = 0;
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: black,
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.model.category,
          style: itemCardHeading,
        ),
        actions: [
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  widget.model.image[selectIndex],
                  fit: BoxFit.cover,
                  width: height / 2,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.model.image.length; i++)
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectIndex = i;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                      child: Image.asset(widget.model.image[i]),
                    ),
                  )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.model.name,
                        style: heading.copyWith(fontSize: 28.0),
                      ),
                    ],
                  ),
                  SpaceVH(height: 20.0),
                  Text(
                    "파마 : 100000원 \n 기장 : 30000원 \n 기타 : 10000원",
                    style: itemCardDes,
                  ),
                  SpaceVH(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Total Price\n',
                            style: subHeading,
                          ),
                          TextSpan(
                            text: widget.model.price,
                            style: itemCardHeading,
                          ),
                        ]),
                      ),
                      Container(
                        height: 40.0,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: TextButton(
                          child: Text(
                            '디자이너 보기',
                            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)
                          ),
                          onPressed: (){
                            print(widget.model.id);
                            Get.to(()=> DesignerPage(designer_id: widget.model.id));
                          },
                        )
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
