import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  void tmp() {
    print("tmp");
    accelerometerEvents.listen((AccelerometerEvent event) {
      print(event);  
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            tmp();
          },
          child: Text("tmp"),
        ),
      ),
    );
  }
}
