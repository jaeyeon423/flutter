import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String profileName;
  final String username;
  final String url;
  final String email;
  final String bio;

  User({
    required this.id,
    required this.profileName,
    required this.username,
    required this.url,
    required this.email,
    required this.bio,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc.id,
      email: doc['email'],
      username: doc['username'],
      url: doc['photoUrl'],
      profileName: doc['displayName'],
      bio: doc['bio'],
    );
  }
}