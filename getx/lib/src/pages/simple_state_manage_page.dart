import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/src/controller/count_controller_with_getx.dart';
import 'package:getx/src/controller/count_controller_with_provider.dart';
import 'package:getx/src/pages/state/with_getx.dart';
import 'package:getx/src/pages/state/with_provider.dart';
import 'package:provider/provider.dart';

import '../home.dart';

class SimpleStateManagePage extends StatelessWidget {
  const SimpleStateManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CountControllerWithGetX());
    return Scaffold(
      appBar: AppBar(
        title: Text("단순 상태 관리 page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
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
