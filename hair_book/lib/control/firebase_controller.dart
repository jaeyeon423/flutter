import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

class FirebaseController extends GetxController {
  RxString? email;
  final favor_list = List<int>.empty().obs;
  @override
  void onInit() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      email = user.email?.obs;
      print(email);
    }
    favor_list.bindStream(get_favor(email));

    super.onInit();
  }

  Stream<List<int>> get_favor(RxString? cur_email) {
    List<int> f_list = [];

    String email = cur_email != null ? cur_email.value : "";

    Stream<QuerySnapshot> snapshots = FirebaseFirestore.instance
        .collection('user')
        .doc(email)
        .collection('info')
        .snapshots();
    snapshots.listen((QuerySnapshot query) {
      if (query.docChanges.isNotEmpty) {
        print("listen jaeyeon");
        f_list.clear();
      }
    });
    return snapshots.map((snapshot) {
      snapshot.docs.forEach((messageData) {
        print("===jaeyone===");
        print(messageData['favor']);
        favor_list.add(1);
        update(favor_list);
      });
      return f_list.toList();
    });
  }
}
