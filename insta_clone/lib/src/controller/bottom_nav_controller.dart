// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

enum PageName {HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE}

class BottomNavController extends GetxController{
  RxInt pageIndex = 0.obs;

  void changeBottmNav(int value){
    var page = PageName.values[value];

    switch(page){
      case PageName.HOME:
        break;
      case PageName.SEARCH:
        break;
      case PageName.UPLOAD:
        break;
      case PageName.ACTIVITY:
        break;
      case PageName.MYPAGE:
        break;
    }
    pageIndex(value);
  }
}