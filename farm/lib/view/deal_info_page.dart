import 'package:farm/controller/info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DealInfoPage extends GetView<InfoController> {
  const DealInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DealInfoPage'),
      ),
      body: Container(
        child: Obx(() {
          var info = controller.info.value;
          return Column(
            children: [
              Text("data : ${info.bidtime}"),
              Text("name : ${info.chulagtnm}"),
            ],
          );
        }),
      ),
    );
  }
}
