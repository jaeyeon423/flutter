import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_app/components/row_component.dart';

class CategoryComponent extends StatelessWidget {
  final String categoryName;

  CategoryComponent({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
            onPressed: () {
              Get.toNamed('/list');
            },
            child: Text("$categoryName")),
        RowComponent(),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
