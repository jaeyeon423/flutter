import 'package:flutter/material.dart';

import 'package:kakao_profile/src/profile.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ImageCropper',
      theme: ThemeData.light().copyWith(primaryColor: Colors.white),
      home: Profile(
      ),
    );
  }
}
