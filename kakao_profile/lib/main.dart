import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_profile/src/controller/profile_controller.dart';

import 'package:kakao_profile/src/profile.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ImageCropper',
      theme: ThemeData.light().copyWith(primaryColor: Colors.white),
      initialBinding: BindingsBuilder((){
        Get.lazyPut<ProflieController>(() => ProflieController());
      }),
      home: Profile(
      ),
    );
  }
}
