import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YoutubeDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(Get.parameters["videoId"] ?? ""),
      ),
    );
  }
}
