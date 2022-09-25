import 'package:byc/controller/firebase_controller.dart';
import 'package:byc/model/designer_info_model.dart';
import 'package:byc/view/designer_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignerSummaryWidget extends StatelessWidget {
  DesignerSummaryWidget({Key? key, required this.designerInfoModel}) : super(key: key);

  DesignerInfoModel designerInfoModel;

  @override
  Widget build(BuildContext context) {

    FirebaseController controller = Get.put(FirebaseController());

    int? index = designerInfoModel.index;
    String? name = designerInfoModel.name;
    String? shop = designerInfoModel.shop;
    int? year = designerInfoModel.year;

    bool favor = controller.favor_list.contains(index!);
    return GestureDetector(
      onTap: (){
        Get.to(()=> DesignerDetailView(designerInfoModel: designerInfoModel));
        print(index);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        height: 100,
        color: Colors.blueGrey,
        child: Center(
          child: Row(
            children: [
              Expanded(child: Text("<designer summary> \n ${index} - ${name} - ${shop} - ${year}", style: TextStyle(fontSize: 20),)),
              Expanded(
                child: Obx(() =>InkWell(
                    onTap: (){
                      print(index);
                      controller.addFavor(index!);
                    },
                    child: Icon(controller.favor_list.contains(index!) ? Icons.star_rate : Icons.star_border),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
