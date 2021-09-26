import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tmptmp/src/components/block.dart';
import 'package:tmptmp/src/components/grid.dart';

class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 5,),
          Grid(),
          Container(
            child: Center(
              child: Row(
                children: [
                  SizedBox(width: 60,),
                  Container(
                    width: 40,
                    height: 50,
                    child: Text("score"),
                  ),
                  SizedBox(width: 100,),
                  ElevatedButton(
                    onPressed: (){},
                    child: Container(
                      width: 100,
                      height: 50,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            height: 80,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
