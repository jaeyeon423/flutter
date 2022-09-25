import 'package:byc/model/designer_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DesignerListController extends GetxController {
  var designerList = <DesignerInfoModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }
}
