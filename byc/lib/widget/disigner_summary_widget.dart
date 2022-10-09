import 'package:byc/model/designer_info_model.dart';
import 'package:byc/view/designer_detail_view.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignerSummaryWidget extends StatelessWidget {
  DesignerSummaryWidget({Key? key, required this.designerInfoModel})
      : super(key: key);

  DesignerInfoModel designerInfoModel;

  @override
  Widget build(BuildContext context) {
    int? index = designerInfoModel.index;
    String? name = designerInfoModel.name;
    String? shop = designerInfoModel.shop;
    int? year = designerInfoModel.year;

    return GestureDetector(
      onTap: () {
        Get.to(() => DesignerDetailView(designerInfoModel: designerInfoModel),
            transition: Transition.rightToLeft);
        print(index);
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
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 16,
                        ),
                        Text(
                          " 5.0 (1,000) | 10:00 ~ 20:00 | 커트 33,000~",
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
