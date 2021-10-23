import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uidesign03/core/space.dart';
import 'package:uidesign03/core/text_style.dart';
import 'package:uidesign03/model/model.dart';
import 'package:uidesign03/page/details_page.dart';

class ItemCard extends StatelessWidget {
  final Model model;
  const ItemCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(()=>DetailsPage(model: model));
      },
      child: Container(
        width: 140.0,
        child: Image.asset(model.image[0]),
      ),
    );
  }
}
