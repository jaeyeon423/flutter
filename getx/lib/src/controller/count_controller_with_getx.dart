import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CountControllerWithGetX extends GetxController{
  int count = 0;
  void increase(){
    count++;
    update(['first']);
  }
}