import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tmptmp/src/components/block.dart';

class Grid extends StatefulWidget {
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  List<int> numlist = [];

  void shuffleNumList(){
    numlist.shuffle();
  }

  @override
  void initState() {
    for(int i = 0; i < 42 ; i++){
      numlist.add(i);
    }
    numlist.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: StaggeredGridView.countBuilder(
        itemCount: 42,
        crossAxisCount: 6,
        itemBuilder: (BuildContext context, int index) => Block(index: numlist[index]),
        staggeredTileBuilder: (int index) =>
        new StaggeredTile.count(1, index.isEven ? 1 : 1),
      ),
    );
  }
}
