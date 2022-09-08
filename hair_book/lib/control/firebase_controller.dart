import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class FirebaseController extends GetxController {
  RxString? email;
  RxList? favor_list;
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

      if (email != null) {
        readdata(email);
      }
    }
  }

  void readdata(RxString? cur_email) {
    var documentSnapshot = FirebaseFirestore.instance
        .collection("user")
        .doc("$cur_email")
        .collection('favor')
        .snapshots();
    print(documentSnapshot);
  }
}
