import 'package:covid19_safe_area/src/controller/covid_statistics_controller.dart';
import 'package:covid19_safe_area/src/model/covid_area_statistics.dart';
import 'package:covid19_safe_area/src/screen/showMap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:vector_map/vector_map.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'corona safe area',
      initialBinding: BindingsBuilder(() {
        Get.put(CovidStatisticsController());
      }),
      home: ShowMap(),
    );
  }
}

