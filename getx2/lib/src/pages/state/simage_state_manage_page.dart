import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2/src/controller/count_controller_with_getx.dart';
import 'package:getx2/src/controller/count_controller_with_provider.dart';
import 'package:getx2/src/pages/state/with_getx.dart';
import 'package:getx2/src/pages/state/with_provider.dart';
import 'package:provider/provider.dart';

class SimpleStateManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(CountControllerWithGetX());
    return Scaffold(
      appBar: AppBar(
        title: Text("simple state manage page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: WithGetX()),
            Expanded(
              child: ChangeNotifierProvider<CountControllerWithProvider>(
                create: (_) => CountControllerWithProvider(),
                child: WithProvider(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
