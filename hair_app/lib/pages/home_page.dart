import 'package:flutter/material.dart';
import 'package:hair_app/components/category_component.dart';
import 'package:hair_app/components/row_component.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "category page",
            style: TextStyle(color: Colors.black38),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CategoryComponent(
                categoryName: "커트",
              ),
              CategoryComponent(
                categoryName: "파마",
              ),
              CategoryComponent(
                categoryName: "염색",
              ),
              CategoryComponent(
                categoryName: "드라이",
              ),
              CategoryComponent(
                categoryName: "클리닉",
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.explore), label: "search"),
          ],
        ),
      ),
    );
  }
}
