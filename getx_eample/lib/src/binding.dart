import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_eample/src/controller/count_controller_with_getx.dart';

class BindingPage extends GetView<CountControllerWithGetX> {
  const BindingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Binding Page"),
      ),
      body: Column(
        children: [
          Obx(()=>Text("${controller.count}"),),
          ElevatedButton(onPressed: (){
            controller.increase();
          }, child: Text(""))
        ],
      ),
    );
  }
}
