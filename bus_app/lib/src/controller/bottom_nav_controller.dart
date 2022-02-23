import 'package:get/get.dart';

enum PageType {TYPE1, TYPE2}

class BottomNavController extends GetxController{

  RxInt pageIndex = 0.obs;

  void changeBottmNav(int value) {
    var page = PageType.values[value];

    switch (page) {
      case PageType.TYPE1:
        _changePage(value);
        break;
      case PageType.TYPE2:
        _changePage(value);
        break;
    }
  }

  void _changePage(int value){
    print(value);
    pageIndex(value);
  }

}