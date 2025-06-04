import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/chat_room/domain/entities/chat_room.dart';
import '../features/messaging/domain/entities/message.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createChatRoom(String roomName) async {
    try {
      await _firestore.collection('chat_rooms').add({
        'name': roomName,
        'createdAt': FieldValue.serverTimestamp(),
        'userCount': 0,
      });
    } catch (e) {
      print('Error creating chat room: $e');
    }
  }

  Stream<List<ChatRoom>> getChatRoomsStream() {
    return _firestore
        .collection('chat_rooms')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return ChatRoom(
          id: doc.id,
          name: data['name'] as String,
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          userCount: data['userCount'] as int? ?? 0,
        );
      }).toList();
    });
  }

  Future<void> sendMessage(String roomId, Message message) async {
    try {
      await _firestore
          .collection('chat_rooms')
          .doc(roomId)
          .collection('messages')
          .add(message.toJson());
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  Stream<List<Message>> getMessagesStream(String roomId) {
    return _firestore
        .collection('chat_rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Message(
          id: doc.id,
          roomId: roomId,
          senderId: data['senderId'] as String,
          content: data['content'] as String,
          timestamp: (data['timestamp'] as Timestamp).toDate(),
        );
      }).toList();
    });
  }
}
