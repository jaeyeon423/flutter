// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/src/components/message_popup.dart';
import 'package:insta_clone/src/pages/upload.dart';

enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();
  RxInt pageIndex = 0.obs;

  GlobalKey<NavigatorState> searchPageNavigationKey = GlobalKey<NavigatorState>();

  List<int> bottomHistory = [0];

  Future<bool> willPopAction() async {
    print("will pop action called");
    if (bottomHistory.length == 1) {
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
                title: "시스템",
                message: "종료하시겠습니까?",
                okCallback: () {
                  exit(0);
                },
            cancelCallback: Get.back,
              ));
      return true;
    } else {

      var page = PageName.values[bottomHistory.last];

      if(page == PageName.SEARCH){
        var value = await searchPageNavigationKey.currentState!.maybePop();
        if(value){
          return false;
        }
      }

      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeBottmNav(index, hasGesture: false);
      return false;
    }
  }

  void changeBottmNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];

    switch (page) {
      case PageName.UPLOAD:
        Get.to(() => Upload());
        break;
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.last != value) bottomHistory.add(value);
  }
}
