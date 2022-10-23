import 'package:byc/model/designer_info_model.dart';
import 'package:byc/view/designer_booking_webview_page.dart';
import 'package:byc/view/designer_info_webview_page.dart';
import 'package:byc/widget/favorite_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignerDetailView extends StatelessWidget {
  DesignerDetailView({Key? key, required this.designerInfoModel})
      : super(key: key);

  DesignerInfoModel designerInfoModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Designer Detail",
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image:
                  AssetImage('assets/images/${designerInfoModel.index}_2.png'),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${designerInfoModel.name!} 디자이너 ',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FavoriteButtonn(
                        index: designerInfoModel.index!,
                        name: designerInfoModel.name!,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "편안한 상담과 섬세한 시술로 매력적인 스타일로 보답하겠습니다.",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => DesignerBookingWebviewPage());
                    },
                    child: Text(
                      "예약하기",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                        MediaQuery.of(context).size.width,
                        50,
                      ),
                      backgroundColor: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
