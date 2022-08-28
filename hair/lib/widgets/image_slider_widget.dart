import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair/controller/day_list_controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

final List<String> imgList = [
  'assets/images/20220822.jpg',
  'assets/images/20220822.jpg',
  'assets/images/20220822.jpg',
  'assets/images/20220822.jpg',
  'assets/images/20220822.jpg',
  'assets/images/20220822.jpg',
];

class ImageSliderDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    DayListController dayListController = Get.put(DayListController());
    AutoScrollController auto_controller = AutoScrollController(
      initialScrollOffset: 1000,
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
    );
    return CarouselSlider(
      options: CarouselOptions(
        height: 350,
        onPageChanged: (index, reason) {
          dayListController.changeIndex(index);

        },
      ),
      items: imgList
          .map(
            (item) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(item),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
