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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.precision_manufacturing_sharp,
            ),
            TextButton(
              onPressed: () {
                Get.toNamed('/list');
              },
              child: Text(
                "$categoryName",
                style: TextStyle(color: Colors.lightBlue),
              ),
            ),
          ],
        ),
        RowComponent(),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
