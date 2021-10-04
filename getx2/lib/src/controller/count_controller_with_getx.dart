import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CountControllerWithGetX extends GetxController {
  static CountControllerWithGetX get to => Get.find();
  int count = 0;
  RxInt tmp = 0.obs;
  void increase(String id){
    count++;
    update(['${id}']);
  }
  void obxincrease(){
    tmp(10);
  }
}