import 'package:get/get.dart';

class DayListController extends GetxController {
  RxInt selectedDat = 0.obs;

  void changeIndex(int index) {
    selectedDat.value = index;
    print(selectedDat.value);
  }
}
