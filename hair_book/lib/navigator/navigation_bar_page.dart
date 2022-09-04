import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_book/control/navigation_controller.dart';
import 'package:hair_book/view/book_page_view.dart';
import 'package:hair_book/view/designer_list_view.dart';
import 'package:hair_book/view/my_page_view.dart';

class NavigationBarPage extends StatelessWidget {
  NavigationBarPage({super.key});
  BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());

  final screen = [
    DesignerListView(),
    BookPageView(),
    MyPageView(),
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
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black26,
          onTap: (index) {
            bottomNavigationController.changeIndex(index);
          },
          currentIndex: bottomNavigationController.selectedIndex.value,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'home',
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
