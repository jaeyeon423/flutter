import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/src/controller/dependency_controller.dart';
import 'package:getx_tutorial/src/pages/dependencys/get_lazy.dart';
import 'package:getx_tutorial/src/pages/dependencys/get_put.dart';

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
                  Get.to(
                    GetPut(),
                    binding: BindingsBuilder(() {
                      Get.put(DependencyController());
                    }),
                  );
                },
                child: Text("GetPut")),
            ElevatedButton(
                onPressed: () {
                  Get.to(
                    GetLazy(),
                    binding: BindingsBuilder(() {
                      Get.lazyPut(() => DependencyController());
                    }),
                  );
                },
                child: Text("Get.lazyput")),
            ElevatedButton(
                onPressed: () {
                  Get.to(
                    GetPut(),
                    binding: BindingsBuilder(() {
                      Get.putAsync<DependencyController>(() async {
                        await Future.delayed(Duration(seconds: 10));
                        return DependencyController();
                      });
                    }),
                  );
                },
                child: Text("Get.putAsync")),
            ElevatedButton(onPressed: () {
              Get.to(
                GetPut(),
                binding: BindingsBuilder(() {
                  Get.create<DependencyController>(() => DependencyController());
                }),
              );
            }, child: Text("Get.create")),
          ],
        ),
      ),
    );
  }
}
