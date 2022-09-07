import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  var selectedIndex = 1.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
