import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/src/components/youtube_bottom_sheet.dart';

enum RoutName {Home, Explore, Add, Subscribe, Library}

class AppController extends GetxService{
  static AppController get to => Get.find();

  RxInt currentIndex = 0.obs;

  void changePageIndex(int index){
    if(RoutName.values[index] == RoutName.Add){
      _showBottomSheet();
    }else{
      currentIndex(index);
    }
  }

  void _showBottomSheet(){
    Get.bottomSheet(YoutubeBottomSheet());
  }
}