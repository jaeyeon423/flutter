import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("list page")
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(20, (index) {
          return Center(
            child: ElevatedButton(onPressed: (){Get.toNamed('/detail');},style: ElevatedButton.styleFrom(primary: Colors.white), child: Image(image: AssetImage('assets/images/first.png'),)),
          );
        }),
      ),
    );
  }
}
