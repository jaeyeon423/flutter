import 'package:byc/model/designer_info_model.dart';
import 'package:byc/view/designer_booking_webview_page.dart';
import 'package:byc/view/designer_info_webview_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignerDetailView extends StatelessWidget {
  DesignerDetailView({Key? key, required this.designerInfoModel}) : super(key: key);

  DesignerInfoModel designerInfoModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DesignerDetailView"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("${designerInfoModel.name} \n${designerInfoModel.year} \n${designerInfoModel.shop} \n${designerInfoModel.index} \n "),
            ElevatedButton(onPressed: (){
              Get.to(()=> DesignerInfoWebviewPage());
            }, child: Text("예약하기")),
          ],
        ),
      ),
    );
  }
}
