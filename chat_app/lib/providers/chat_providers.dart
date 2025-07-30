import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_app/models/chat_message.dart';

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final messagesStreamProvider = StreamProvider<List<ChatMessage>>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  
  return firestore
      .collection('chat')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => ChatMessage.fromFirestore(doc))
          .toList());
});

final chatServiceProvider = Provider<ChatService>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return ChatService(firestore);
});

class ChatService {
  const ChatService(this._firestore);
  
  final FirebaseFirestore _firestore;

  Future<void> sendMessage({
    required String text,
    required String userId,
    required String userEmail,
    required String userName,
    required String userImage,
  }) async {
    final message = ChatMessage(
      text: text,
      userId: userId,
      userEmail: userEmail,
      userName: userName,
      userImage: userImage,
      createdAt: DateTime.now(),
    );

    await _firestore.collection('chat').add(message.toFirestore());
  }
}

final sendMessageProvider = Provider<Future<void> Function({
  required String text,
})>((ref) {
  final chatService = ref.watch(chatServiceProvider);
  final currentUser = FirebaseAuth.instance.currentUser;
  
  return ({required String text}) async {
    if (currentUser == null) return;
    
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();
    
    final userDataMap = userData.data() ?? {};
    
    await chatService.sendMessage(
      text: text,
      userId: currentUser.uid,
      userEmail: currentUser.email ?? '',
      userName: userDataMap['username'] ?? currentUser.email?.split('@')[0] ?? 'Unknown',
      userImage: userDataMap['image_url'] ?? '',
    );
  };
});