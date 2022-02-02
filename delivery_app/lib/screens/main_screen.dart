import 'package:delivery_app/components/food_category.dart';
import 'package:delivery_app/components/icon_content.dart';
import 'package:delivery_app/components/room_content.dart';
import 'package:delivery_app/components/room_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

int category_num = 0;

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var category_food = ['전체', '한식', '치킨', '중식', '양식', '디저트'];
  List<String> foodList = [];

  Widget _button_cate(int cate_num) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            category_num = cate_num;
          });
        },
        child: Text(category_food[cate_num]),
        style: ElevatedButton.styleFrom(
          primary: category_num == cate_num ? Colors.lightBlueAccent : Colors.grey,
          shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        actions: [
          Center(
              child: Text(
            '매탄성일아파트',
            style: TextStyle(color: Colors.black54, fontSize: 20),
          )),
          IconButton(
            onPressed: () {},
            tooltip: '매탄',
            icon: Icon(Icons.location_on),
            iconSize: 20,
            color: Colors.black54,
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
          color: Colors.black54,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var i = 0; i < 5; i++)
                  Container(
                    child: _button_cate(i),
                    width: 100,
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RoomList(category_num: category_num,),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('만들기'),
        onPressed: () {
          Get.toNamed('/create');
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selectedIndex,
        //현재 선택된 Index
        onTap: (int index) {
          // setState(() {
          //   _selectedIndex = index;
          // });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Favorites',
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'My Page',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
