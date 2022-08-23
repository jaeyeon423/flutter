import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:hair/controller/navigation_controller.dart';
import 'package:hair/view/designer_list_page.dart';
import 'package:hair/view/home_page.dart';
import 'package:hair/view/profile_page.dart';
import 'package:hair/view/setting_page.dart';

class NavigationBarPage extends StatelessWidget {
  NavigationBarPage({Key? key}) : super(key: key);

  BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());

  final screen = [
    HomePage(),
    DesignerList(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: bottomNavigationController.selectedIndex.value,
          children: screen,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          // type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) {
            bottomNavigationController.changeIndex(index);
          },
          currentIndex: bottomNavigationController.selectedIndex.value,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.deepOrange,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: '예약하기',
              backgroundColor: Colors.deepPurpleAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
