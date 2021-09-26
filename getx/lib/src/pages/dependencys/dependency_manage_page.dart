import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/src/controller/dependency_controller.dart';
import 'package:getx/src/pages/dependencys/get_lazyput.dart';
import 'package:getx/src/pages/dependencys/get_put.dart';

class DependencyManagePage extends StatelessWidget {
  const DependencyManagePage({Key? key}) : super(key: key);

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
              child: Text("Get put"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => GetLazyPut(), binding: BindingsBuilder(() {
                  Get.lazyPut(() => DependencyController());
                }));
              },
              child: Text("Get.lazyPut"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => GetPut(), binding: BindingsBuilder(() {
                  Get.putAsync<DependencyController>(() async{
                    await Future.delayed(Duration(seconds: 4));
                    return DependencyController();
                  });
                }));
              },
              child: Text("Get.putAsync"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => GetLazyPut(), binding: BindingsBuilder(() {
                  Get.create<DependencyController>(() => DependencyController());
                }));
              },
              child: Text("Get.create"),
            ),
          ],
        ),
      ),
    );
  }
}