import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YoutubeDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("${Get.parameters["videoId"]}"),
      ),
    );
  }
}
