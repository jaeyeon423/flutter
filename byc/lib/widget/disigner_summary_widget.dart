import 'package:byc/controller/database_controller.dart';
import 'package:byc/model/designer_info_model.dart';
import 'package:byc/view/designer_detail_view.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignerSummaryWidget extends GetView<DatabaseController> {
  DesignerSummaryWidget({Key? key, required this.designerInfoModel})
      : super(key: key);

  DesignerInfoModel designerInfoModel;

  @override
  Widget build(BuildContext context) {
    int? index = designerInfoModel.index;
    String? name = designerInfoModel.name;
    String? shop = designerInfoModel.shop;
    int? year = designerInfoModel.year;

    DatabaseController databaseController = Get.put(DatabaseController());

    return GestureDetector(
      onTap: () {
        Get.to(() => DesignerDetailView(designerInfoModel: designerInfoModel),
            transition: Transition.rightToLeft);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image(
                image: AssetImage(
                  'assets/images/${designerInfoModel.index}_2.png',
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${name!} · ${year.toString()}년차",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      shop!,
                      style: TextStyle(fontSize: 15, color: Colors.black38),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "10:00 ~ 20:00  |  커트 33,000~",
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                if (controller.favor_list.contains(index)) {
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
                  color: Colors.yellow,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
