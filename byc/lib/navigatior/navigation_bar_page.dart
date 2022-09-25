import 'package:byc/controller/bottom_navigation_bar_controller.dart';
import 'package:byc/view/designer_list_view.dart';
import 'package:byc/view/my_favorite_view.dart';
import 'package:byc/view/my_page_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NavigationBarPage extends GetView<BottomNavigationBarController> {
  NavigationBarPage({Key? key}) : super(key: key);

  BottomNavigationBarController bottomNavigationController =
      Get.put(BottomNavigationBarController());

  final screen = [
    DesignerListView(),
    MyFavoriteView(),
    MyPageView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: screen,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.black26,
          onTap: (index) {
            bottomNavigationController.changeIndex(index);
          },
          currentIndex: controller.selectedIndex.value,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'list',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'book',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'my page',
            ),
          ],
        ),
      ),
    );
  }
}
