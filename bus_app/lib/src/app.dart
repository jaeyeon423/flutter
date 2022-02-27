import 'package:bus_app/src/controller/bottom_nav_controller.dart';
import 'package:bus_app/src/pages/commute_page.dart';
import 'package:bus_app/src/pages/shuttle_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.pageIndex.value,
          children: [
            CommutePage(),
            ShuttlePage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.pageIndex.value,
          onTap: (value) {
            controller.changeBottmNav(value);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "통근 버스",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "셔틀 버스",
            ),
          ],
        ),
      ),
    );
  }
}
