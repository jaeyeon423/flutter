import 'package:flutter/material.dart';
import 'package:hair_app/components/category_component.dart';
import 'package:hair_app/components/row_component.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("category page"),
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
