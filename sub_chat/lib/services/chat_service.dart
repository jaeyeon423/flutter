import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getMessages(String roomId) {
    return _firestore
        .collection('chatRooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(100)
        .snapshots();
  }

  Future<void> sendMessage({
    required String roomId,
    required String text,
    required String senderId,
    required String senderName,
  }) async {
    if (text.trim().isEmpty) return;

    final message = Message(
      id: '',
      roomId: roomId,
      text: text.trim(),
      senderId: senderId,
      senderName: senderName,
      timestamp: DateTime.now(),
    );

    try {
      final batch = _firestore.batch();

      final messageRef = _firestore
          .collection('chatRooms')
          .doc(roomId)
          .collection('messages')
          .doc();
      batch.set(messageRef, message.toFirestore());

      final chatRoomRef = _firestore.collection('chatRooms').doc(roomId);
      batch.update(chatRoomRef, {
        'lastMessage': {
          'text': message.text,
          'senderId': message.senderId,
          'senderName': message.senderName,
          'timestamp': FieldValue.serverTimestamp(),
        },
        'updatedAt': FieldValue.serverTimestamp(),
      });

      await batch.commit();
    } catch (e) {
      throw Exception('메시지 전송 실패: ${e.toString()}');
    }
  }

  Stream<DocumentSnapshot> getChatRoom(String roomId) {
    return _firestore.collection('chatRooms').doc(roomId).snapshots();
  }

  Future<void> initializeChatRoom() async {
    const roomId = 'general';
    final chatRoomRef = _firestore.collection('chatRooms').doc(roomId);
    
    final doc = await chatRoomRef.get();
    if (!doc.exists) {
      await chatRoomRef.set({
        'name': '일반 채팅',
        'description': '모든 사용자가 참여하는 채팅방',
        'createdAt': FieldValue.serverTimestamp(),
        'memberCount': 0,
        'lastMessage': null,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> incrementMemberCount(String roomId) async {
    try {
      await _firestore.collection('chatRooms').doc(roomId).update({
        'memberCount': FieldValue.increment(1),
      });
    } catch (e) {
      print('멤버 수 증가 실패: $e');
    }
  }

  Future<void> decrementMemberCount(String roomId) async {
    try {
      await _firestore.collection('chatRooms').doc(roomId).update({
        'memberCount': FieldValue.increment(-1),
      });
    } catch (e) {
      print('멤버 수 감소 실패: $e');
    }
  }

  List<Message> parseMessages(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList();
  }

  ChatRoom? parseChatRoom(DocumentSnapshot doc) {
    if (!doc.exists) return null;
    return ChatRoom.fromFirestore(doc);
  }
}