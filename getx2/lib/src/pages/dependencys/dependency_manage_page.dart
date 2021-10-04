import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2/src/controller/dependency_controller.dart';
import 'package:getx2/src/pages/dependencys/get_lazy_put.dart';
import 'package:getx2/src/pages/dependencys/get_put.dart';

class DependencyManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("의존성 주입"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(() => GetPut(), binding: BindingsBuilder(() {
                    Get.put(() => DependencyController());
                  }));
                },
                child: Text("get put")),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => GetLazyPut(), binding: BindingsBuilder(() {
                    Get.lazyPut<DependencyController>(
                        () => DependencyController());
                  }));
                },
                child: Text("get.lazyPut")),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => GetPut(), binding: BindingsBuilder(() {
                    Get.putAsync<DependencyController>(() async {
                      await Future.delayed(Duration(seconds: 5));
                      return DependencyController();
                    });
                  }));
                },
                child: Text("get.putAsync")),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => GetPut(), binding: BindingsBuilder(() {
                    Get.create<DependencyController>(() => DependencyController());
                  }));
                },
                child: Text("get.create")),
          ],
        ),
      ),
    );
  }
}
