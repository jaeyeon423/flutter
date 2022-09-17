import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

class FirebaseController extends GetxController {
  RxString? email;
  RxList<int> favor_list = <int>[].obs;
  @override
  void onInit() async {
    email = FirebaseAuth.instance.currentUser!.email?.obs;
    favor_list.bindStream(stream);
    print("jaeyeon");
    print(favor_list);
    super.onInit();
  }

  // return Stream<List<int>> from firebase
  Stream<List<int>> get stream {
    return FirebaseFirestore.instance
        .collection('user')
        .doc('jaeyeon423@gmail.com')
        .collection('info')
        .snapshots()
        .map((event) {
      print("=======");
      print(event.docs[0].data()['favor']);
      print("=======");
      return event.docs[0].data()['favor'].cast<int>() as List<int>;
    });
  }
}
