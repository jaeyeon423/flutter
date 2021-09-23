import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:youtube_copy/src/controller/app_controller.dart';
import 'package:youtube_copy/src/pages/explore.dart';
import 'package:youtube_copy/src/pages/home.dart';
import 'package:youtube_copy/src/pages/library.dart';
import 'package:youtube_copy/src/pages/subscribe.dart';

class App extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch(RouteName.values[controller.currentIndex.value]){
          case RouteName.Home :
            return Home();
          case RouteName.Explore :
            return Explore();
          case RouteName.Add :
            break;
          case RouteName.Subscribe :
            return Subscribe();
          case RouteName.Library :
            return Library();
        }
        return Container();
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentIndex.value,
          showSelectedLabels: true,
          selectedItemColor: Colors.black,
          onTap: (index) {
            controller.chagePageIndex(index);
          },
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/svg/icons/home_off.svg"),
                activeIcon: SvgPicture.asset("assets/svg/icons/home_on.svg"),
                label: "home"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/icons/compass_off.svg",
                  width: 22,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/svg/icons/compass_on.svg",
                  width: 22,
                ),
                label: "search"),
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
                label: "subscribe"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/icons/library_off.svg",
                  width: 22,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/svg/icons/library_on.svg",
                  width: 22,
                ),
                label: "library"),
          ],
        ),
      ),
    );
  }
}
