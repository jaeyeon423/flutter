import 'package:get/get.dart';
import 'package:getx_eample/src/controller/count_controller_with_getx.dart';

class BindingPageBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(CountControllerWithGetX());
  }

}