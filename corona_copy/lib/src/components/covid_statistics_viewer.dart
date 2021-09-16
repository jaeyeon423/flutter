import 'package:corona_copy/src/canvas/arrow_clip_path.dart';
import 'package:corona_copy/src/utils/data_utils.dart';
import 'package:flutter/material.dart';

class CovidStatisticsViewer extends StatelessWidget {
  final String title;
  final double addedCount;
  final ArrowDirection upDown;
  final double totalCount;
  final bool dense;
  final Color titleColor;
  final Color subValueColor;
  final double spacing;

  CovidStatisticsViewer({
    required this.title,
    required this.addedCount,
    required this.upDown,
    required this.totalCount,
    this.dense = false,
    this.titleColor = const Color(0xff4c4e5d),
    this.subValueColor = Colors.black,
    this.spacing = 10,
  });

  @override
  Widget build(BuildContext context) {
    var color = Colors.black;

    switch(upDown){
      case ArrowDirection.UP:
        color = Colors.deepOrangeAccent;
        break;
      case ArrowDirection.DOWN:
        color = Colors.lightBlue;
        break;
      case ArrowDirection.MIDDLE:
        break;
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: subValueColor,
              fontSize: dense? 13 : 18,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipPath(
                child: Container(
                  width: 20,
                  height: 20,
                  color: color,
                ),
                clipper: ArrowClipPath(direction: upDown),
              ),
              SizedBox(height: 5,),
              Text(
                DataUtils.numberFormat(addedCount),
                style: TextStyle(
                    color: color,
                    fontSize: dense ? 25 : 50,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            DataUtils.numberFormat(totalCount),
            style: TextStyle(
              color: subValueColor,
              fontSize: dense ? 15 : 20,
            ),
          ),
        ],
      ),
    );
  }
}
