import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CountControllerWithGetX extends GetxController{
  static CountControllerWithGetX get to => Get.find();
  RxInt count = 0.obs;
  void increase(){
    count++;
    update();
  }
}