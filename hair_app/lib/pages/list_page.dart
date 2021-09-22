import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffff0),
      appBar: AppBar(
        elevation: 0,
        shadowColor: Color(0xfffffff0),
        backgroundColor: Color(0xfffffff0),
        title: Text(
          "list page",
          style: TextStyle(color: Colors.black38),
        ),
      ),
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
                  height: 120,
                )),
          );
        }),
      ),
    );
  }
}
