import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/components/room_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

int category_num = 0;

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('user');
  CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');

  void _getUserInfo() async {
    await users
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
        users.doc(FirebaseAuth.instance.currentUser!.email).set({
          'delivery_status': 0,
        });
      }
    });
  }

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  var category_food = ['전체', '한식', '치킨', '중식', '양식', '디저트'];
  Widget _button_cate(int cate_num) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            category_num = cate_num;
          });
        },
        child: Text(
          category_food[cate_num],
          style: TextStyle(color: Colors.black54),
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            side: BorderSide(
              color: category_num == cate_num ? Colors.black54 : Colors.white,
              width: 2,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Center(
              child: Text(
                '매탄성일아파트',
                style: TextStyle(color: Colors.black54, fontSize: 20),
              ),
            ),
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
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            child: Container(
              color: Colors.white,
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
          ),
          const SizedBox(
            height: 20,
          ),
          RoomList(
            category_num: category_num,
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Text('만들기'),
      //   onPressed: () {
      //     Get.toNamed('/create');
      //   },
      // ),
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
          if (index == 0) FirebaseAuth.instance.signOut();
          switch (index) {
            case 0:
              FirebaseAuth.instance.signOut();
              break;
            case 1:
              Get.toNamed('/current_status');
          }
        },
        items: [
          BottomNavigationBarItem(
            label: '검색',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: '배달 현황',
            icon: Icon(Icons.motorcycle),
          ),
          BottomNavigationBarItem(
            label: '프로필',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}