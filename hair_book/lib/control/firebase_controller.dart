import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

class FirebaseController extends GetxController {
  RxString? email;
  final favor_list = List<int>.empty().obs;
  @override
  void onInit() async {
    super.onInit();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final name = user.displayName;
      email = user.email?.obs;
      print(name);
      print(email);
    }

    // favor_list.bindStream(stream)
    favor_list.bindStream(get_favor(email));
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
