import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class FirebaseController extends GetxController {
  RxString? email;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final name = user.displayName;
      email = user.email?.obs;
      print(name);
      print(email);
    }
  }
}
