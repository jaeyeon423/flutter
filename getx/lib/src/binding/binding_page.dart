import 'package:get/get.dart';
import 'package:getx/src/controller/count_controller_with_getx.dart';

class BindingPageBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(() => CountControllerWithGetX());
  }

}