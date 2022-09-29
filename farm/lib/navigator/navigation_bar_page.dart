import 'package:farm/controller/bottom_navigation_bar_controller.dart';
import 'package:farm/view/deal_info_page.dart';
import 'package:farm/view/my_favorite_page.dart';
import 'package:farm/view/price_info_page.dart';
import 'package:farm/view/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class NavigationBarPage extends StatelessWidget {
  NavigationBarPage({super.key});

  BottomNavigationBarController ctr = Get.put(BottomNavigationBarController());

  final screen = [
    MyFavoritePage(),
    DealInfoPage(),
    PriceInnfoPage(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: ctr.selectedIndex.value,
          children: screen,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.black26,
          showUnselectedLabels: true,
          onTap: (index) {
            ctr.changeIndex(index);
          },
          currentIndex: ctr.selectedIndex.value,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.star_border),
              label: '즐겨찾기',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: '실거래',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.price_change_outlined),
              label: '가격 정보',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '품종 검색',
            ),
          ],
        ),
      ),
    );
  }
}
