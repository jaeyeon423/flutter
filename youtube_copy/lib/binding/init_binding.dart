import 'package:get/get.dart';
import 'package:youtube_copy/controller/app_controller.dart';

class InitBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AppController());
  }

}