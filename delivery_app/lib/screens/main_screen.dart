import 'package:delivery_app/components/food_category.dart';
import 'package:delivery_app/components/icon_content.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        actions: [
          Center(child: Text('가나다라마바사', style: TextStyle(color: Colors.black54, fontSize: 20),)),
          IconButton(onPressed: (){}, tooltip:'매탄',icon: Icon(Icons.location_on), iconSize: 20, color: Colors.black54,),
        ],
        leading: IconButton(icon: Icon(Icons.menu), onPressed: (){}, color: Colors.black54,),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          FoodCategory(),
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width - 50,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}

