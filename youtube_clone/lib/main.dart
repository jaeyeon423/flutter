import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/src/binding/init_binding.dart';
import 'package:youtube_clone/src/app.dart';
import 'package:youtube_clone/src/components/youtube_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Youtube clone App",
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      initialBinding: InitBinding(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: ()=>App()),
        GetPage(name: '/detail/:videoId', page: ()=>YoutubeDetail()),
      ],
    );
  }
}
