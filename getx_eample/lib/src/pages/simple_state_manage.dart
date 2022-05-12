import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_eample/src/controller/count_controller_with_getx.dart';
import 'package:getx_eample/src/controller/count_controller_with_provider.dart';
import 'package:getx_eample/src/pages/state/with_getx.dart';
import 'package:getx_eample/src/pages/state/with_provider.dart';
import 'package:provider/provider.dart';

class SimpleStateManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(CountControllerWithGetX());
    return Scaffold(
      appBar: AppBar(
        title: Text("simple state manage ge"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: WithGetX(),
            ),
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
