import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  const ChatMessage({
    required this.text,
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.userImage,
    required this.createdAt,
  });

  final String text;
  final String userId;
  final String userEmail;
  final String userName;
  final String userImage;
  final DateTime createdAt;

  factory ChatMessage.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatMessage(
      text: data['text'] ?? '',
      userId: data['userId'] ?? '',
      userEmail: data['userEmail'] ?? '',
      userName: data['userName'] ?? '',
      userImage: data['userImage'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'text': text,
      'userId': userId,
      'userEmail': userEmail,
      'userName': userName,
      'userImage': userImage,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}