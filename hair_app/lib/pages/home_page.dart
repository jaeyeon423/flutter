import 'package:flutter/material.dart';
import 'package:hair_app/components/category_component.dart';
import 'package:hair_app/components/row_component.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfffffff0),
        appBar: AppBar(
          elevation: 0,
          shadowColor: Color(0xfffffff0),
          backgroundColor: Color(0xfffffff0),
          foregroundColor: Color(0xfffffff0),
          title: Text("category page", style: TextStyle(color: Colors.black38),),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CategoryComponent(categoryName: "커트",),
              CategoryComponent(categoryName: "파마",),
              CategoryComponent(categoryName: "염색",),
              CategoryComponent(categoryName: "드라이",),
              CategoryComponent(categoryName: "클리닉",),

            ],
          ),
        )
      ),
    );
  }
}
