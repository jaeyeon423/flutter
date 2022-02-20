import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/src/components/image_data.dart';
import 'package:insta_clone/src/controller/bottom_nav_controller.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        child: Scaffold(
          appBar: AppBar(),
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              Container(child: Center(child: Text("home"),),),
              Container(child: Center(child: Text("search"),),),
              Container(child: Center(child: Text("add"),),),
              Container(child: Center(child: Text("activity"),),),
              Container(child: Center(child: Text("mypage"),),),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            currentIndex: controller.pageIndex.value,
            onTap: (value) {
              controller.changeBottmNav(value);
            },
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.homeOff),
                  activeIcon: ImageData(IconsPath.homeOn),
                  label: "home"),
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.searchOff),
                  activeIcon: ImageData(IconsPath.searchOn),
                  label: "home"),
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.uploadIcon), label: "home"),
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.activeOff),
                  activeIcon: ImageData(IconsPath.activeOn),
                  label: "home"),
              BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    width: 30,
                    height: 30,
                  ),
                  label: "home"),
            ],
          ),
        ),
        onWillPop: () async {
          return false;
        },
      ),
    );
  }
}
