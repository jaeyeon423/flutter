import 'package:flutter/material.dart';

class Block extends StatefulWidget {
  final int index;
  Block({required this.index});

  @override
  _BlockState createState() => _BlockState();
}

class _BlockState extends State<Block> {
  bool vis = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: vis,
      child: InkWell(
        onTap: () {
          print(widget.index);
          vis = false;
          setState(() {

          });
        },
        child: Container(
          margin: const EdgeInsets.all(2.0),
          color: Colors.blueGrey,
          child: new Center(
            child: new Text('${widget.index+1}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
          ),
        ),
      ),
    );
  }
}
