import 'package:get/get.dart';

class CountControllerWithReactive extends GetxController{
  RxInt count = 0.obs;

  void increase(){
    count++;
  }
  void putNumber(int value){
    count(value);
  }

  @override
  void onInit() {
    ever(count, (_) => print("매번 호출"));
    once(count, (_) => print("한번만 호출"));
    super.onInit();
  }
}