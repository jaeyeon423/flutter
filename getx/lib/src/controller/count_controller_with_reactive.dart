import 'package:get/get.dart';

class User {
  String name;
  int age;
  User({required this.name, required this.age});
}

class CountControllerWithReactive extends GetxController{
  RxInt count = 0.obs;
  Rx<User> user = User(name: "jaeyeon", age: 30).obs;

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