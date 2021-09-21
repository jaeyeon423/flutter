import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("list page")),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 3,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(20, (index) {
          return Center(
            child: InkWell(
                onTap: () {
                  Get.toNamed('/detail');
                },
                child: Image(
                  image: AssetImage('assets/images/first.png'),
                  width: double.infinity,
                  height: 300,
                )),
          );
        }),
      ),
    );
  }
}
