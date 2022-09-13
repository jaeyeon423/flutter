import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

class FirebaseController extends GetxController {
  RxString? email;
  RxList favor_list = [].obs;
  @override
  void onInit() async {
    super.onInit();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final name = user.displayName;
      email = user.email?.obs;
      print(name);
      print(email);

      if (email != null) {
        favor_list = await readdata(email);
      }
    }
  }

  Stream<RxList> readdata(RxString? cur_email) async* {
    if (cur_email != null) {
      FirebaseFirestore.instance
          .collection('user')
          .doc(cur_email.value)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print('Document exists on the database${documentSnapshot['favor']}');
          List<dynamic> tmp_list = documentSnapshot['favor'];
          print(tmp_list);
          var f_list = tmp_list.obs;
          return f_list;
        }
      });
    }
  }
}
