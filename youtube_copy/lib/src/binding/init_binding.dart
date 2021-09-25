import 'package:get/get.dart';
import 'package:youtube_copy/src/controller/app_controller.dart';
import 'package:youtube_copy/src/repository/youtube_repository.dart';

class InitBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AppController());
    Get.put(YoutubeRepository(), permanent: true);
  }

}