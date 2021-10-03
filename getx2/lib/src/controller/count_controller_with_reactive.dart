
import 'package:get/get.dart';

enum NUM{FIRST, SECOND}

class User{
  int age;
  User({required this.age});
}

class CountControllerWithReactive extends GetxController{
  RxInt count = 0.obs;
  RxDouble doubleCount = 0.0.obs;
  RxList rxList = [].obs;
  Rx<NUM> nums = NUM.FIRST.obs;
  Rx<User> user = User(age: 30).obs;

  void increase(){
    count++;
    
    user(User(age: 20));
    user.update((_user) {_user!.age = 25;});
  }

  void putNumber(int value){
    count(value);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    ever(count, (_)=> print("매번 호출"));
    once(count, (_)=> print("한번만 호출"));
    debounce(count, (_)=> print("마지막 변경에 한번만 호출"), time: Duration(seconds: 1));
    interval(count, (_)=> print("변경되고 있는 동안에 1초마다 호출"), time: Duration(seconds: 1));
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}