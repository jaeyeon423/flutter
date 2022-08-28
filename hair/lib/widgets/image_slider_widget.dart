import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
    return CarouselSlider(
      options: CarouselOptions(
        height: 350,
        onPageChanged: (index, reason) {
          print(index);
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
