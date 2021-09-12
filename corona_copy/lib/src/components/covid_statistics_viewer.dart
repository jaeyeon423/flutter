import 'package:corona_copy/src/canvas/arrow_clip_path.dart';
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
    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              ClipPath(
                child: Container(
                  width: 20,
                  height: 20,
                  color: Colors.orange,
                ),
                clipper: ArrowClipPath(),
              ),
              Text(
                addedCount.toInt().toString(),
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            '${totalCount.toInt()}',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
