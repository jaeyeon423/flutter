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
    super.onInit();
  }

  //add user's favor list to firebase
  void addFavor(int index) {
    if (favor_list.contains(index)) {
      favor_list.remove(index);
    } else {
      favor_list.add(index);
      favor_list.sort();
    }
    print(favor_list);
    FirebaseFirestore.instance
        .collection('user')
        .doc(email!.value)
        .collection('info')
        .doc('favor')
        .set({'list': favor_list});
  }

  // return Stream<List<int>> from firebase
  Stream<List<int>> get stream {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(email!.value)
        .collection('info')
        .snapshots()
        .map((event) {
      // print(event.docs[0].data()['list']);
      return event.docs[0].data()['list'].cast<int>() as List<int>;
    });
  }
}
