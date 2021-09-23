import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:youtube_copy/src/binding/init_binding.dart';
import 'package:youtube_copy/src/app.dart';
import 'package:youtube_copy/src/components/yotube_detail.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "youtube clone app",
      theme: ThemeData(
          primaryColor: Colors.white,
          primarySwatch: Colors.lightBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: '/',
      initialBinding: InitBinding(),
      getPages: [
        GetPage(name: '/', page: () => App()),
        GetPage(name: '/detail/:videoId', page: () => YoutubeDetail()),
      ],
    );
  }
}
