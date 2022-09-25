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

  //add user's favor list to firebase
  void addFavor(int index) {
    if (favor_list.contains(index)) {
      favor_list.remove(index);
    } else {
      favor_list.add(index);
      favor_list.sort();
    }
    FirebaseFirestore.instance
        .collection('user')
        .doc(email!.value)
        .collection('info')
        .doc('favor')
        .set({'favor_list': favor_list});
  }

  // return Stream<List<int>> from firebase
  Stream<List<int>> get stream {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(email!.value)
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
