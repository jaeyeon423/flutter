import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum NUM{FIRST, SECOND}

class CountControllerWithReactive extends GetxController{
  RxInt count = 0.obs;
  Rx<NUM> nums = NUM.FIRST.obs;

  void increase(){
    count++;

    nums(NUM.SECOND);
  }

  void putNumber(int value){
    count(value);
  }

  @override
  void onInit() {
    // ever(count,(_)=>print("매번 호출"));
    // once(count,(_)=>print("한번만 호출"));
    // debounce(count,(_)=>print("마지막 변경 호출"), time: Duration(seconds: 1));
    interval(count, (_)=>print("변경되고 1초마다 변경"), time: Duration(seconds: 1));
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

}