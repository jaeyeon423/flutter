import 'package:corona_copy/src/app.dart';
import 'package:corona_copy/src/controller/covid_statistics_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'flutter Demo',
      initialBinding: BindingsBuilder((){
        Get.put(CovidStatisticsController());
      }),
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: App(),
    );
  }
}
