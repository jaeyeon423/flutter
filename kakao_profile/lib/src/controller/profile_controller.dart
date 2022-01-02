import 'package:get/get.dart';

class ProflieController extends GetxController{
  RxBool isEditMyProfile = false.obs;

  @override
  void onInit() {
    isEditMyProfile(false);
    super.onInit();
  }
  void toggleEditProfile(){
    isEditMyProfile(!isEditMyProfile.value);
  }
}