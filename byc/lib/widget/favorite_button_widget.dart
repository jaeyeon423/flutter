import 'package:byc/controller/database_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteButtonn extends GetView<DatabaseController> {
  FavoriteButtonn({super.key, required this.index, required this.name});

  DatabaseController databaseController = Get.put(DatabaseController());

  final int index;
  final String name;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (!controller.favor_list.contains(index)) {
          controller.insertFavor(Favorite(id: index!, name: name));
          controller.updateFavor();
        } else {
          controller.deleteFavor(index!);
          controller.updateFavor();
        }
      },
      icon: Obx(
        () => Icon(
          controller.favor_list.contains(index)
              ? Icons.star
              : Icons.star_border,
          size: 30,
          color: Color.fromARGB(255, 219, 190, 45),
        ),
      ),
    );
  }
}
