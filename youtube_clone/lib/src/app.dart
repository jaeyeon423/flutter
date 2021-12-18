import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/src/controller/app_controller.dart';
import 'package:youtube_clone/src/pages/explore.dart';
import 'package:youtube_clone/src/pages/home.dart';
import 'package:youtube_clone/src/pages/library.dart';
import 'package:youtube_clone/src/pages/subscribe.dart';

class App extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch(RoutName.values[controller.currentIndex.value]){

          case RoutName.Home:
            return Home();
            break;
          case RoutName.Explore:
            return Explore();
            break;
          case RoutName.Subscribe:
            return Subscribe();
            break;
          case RoutName.Library:
            return Library();
            break;
        }
        return Container();
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentIndex.value,
          showUnselectedLabels: true,
          selectedItemColor: Colors.black54,
          onTap: controller.changePageIndex,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/icons/home_off.svg",
                  width: 22,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/svg/icons/home_on.svg",
                  width: 22,
                ),
                label: "홈"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/icons/compass_off.svg",
                  width: 22,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/svg/icons/compass_on.svg",
                  width: 22,
                ),
                label: "탐색"),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SvgPicture.asset(
                    "assets/svg/icons/plus.svg",
                    width: 35,
                  ),
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/icons/subs_off.svg",
                  width: 22,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/svg/icons/subs_on.svg",
                  width: 22,
                ),
                label: "구독"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/icons/library_off.svg",
                  width: 22,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/svg/icons/library_on.svg",
                  width: 22,
                ),
                label: "보관함"),
          ],
        ),
      ),
    );
  }
}
