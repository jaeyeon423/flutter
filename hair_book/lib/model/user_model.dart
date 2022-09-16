import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  List favor_list;

  UserModel({required this.name, required this.favor_list});

  factory UserModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> doc}) {
    return UserModel(
      name: doc.data()!["email"],
      favor_list: doc.data()!["favor"],
    );
  }
}
