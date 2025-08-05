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

      // 메시지 추가
      final messageRef = _firestore
          .collection('chatRooms')
          .doc(roomId)
          .collection('messages')
          .doc();
      batch.set(messageRef, message.toFirestore());

      // 채팅방 문서 확인 및 생성/업데이트
      final chatRoomRef = _firestore.collection('chatRooms').doc(roomId);
      final chatRoomDoc = await chatRoomRef.get();
      
      if (chatRoomDoc.exists) {
        // 기존 채팅방 업데이트
        batch.update(chatRoomRef, {
          'lastMessage': {
            'text': message.text,
            'senderId': message.senderId,
            'senderName': message.senderName,
            'timestamp': FieldValue.serverTimestamp(),
          },
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } else {
        // 새 채팅방 생성 (지하철 열차 채팅방)
        final roomName = _generateRoomName(roomId);
        batch.set(chatRoomRef, {
          'name': roomName,
          'description': _generateRoomDescription(roomId),
          'type': 'train', // 열차 채팅방 타입
          'trainId': _extractTrainId(roomId),
          'subwayLine': _extractSubwayLine(roomId),
          'createdAt': FieldValue.serverTimestamp(),
          'memberCount': 1,
          'lastMessage': {
            'text': message.text,
            'senderId': message.senderId,
            'senderName': message.senderName,
            'timestamp': FieldValue.serverTimestamp(),
          },
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

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
      final chatRoomRef = _firestore.collection('chatRooms').doc(roomId);
      final chatRoomDoc = await chatRoomRef.get();
      
      if (chatRoomDoc.exists) {
        // 기존 채팅방 멤버 수 증가
        await chatRoomRef.update({
          'memberCount': FieldValue.increment(1),
        });
      } else {
        // 새 채팅방 생성 (지하철 열차 채팅방)
        final roomName = _generateRoomName(roomId);
        await chatRoomRef.set({
          'name': roomName,
          'description': _generateRoomDescription(roomId),
          'type': 'train', // 열차 채팅방 타입
          'trainId': _extractTrainId(roomId),
          'subwayLine': _extractSubwayLine(roomId),
          'createdAt': FieldValue.serverTimestamp(),
          'memberCount': 1, // 초기 멤버 수
          'lastMessage': null,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      // 멤버 수 증가 실패
    }
  }

  Future<void> decrementMemberCount(String roomId) async {
    try {
      final chatRoomRef = _firestore.collection('chatRooms').doc(roomId);
      final chatRoomDoc = await chatRoomRef.get();
      
      if (chatRoomDoc.exists) {
        final currentData = chatRoomDoc.data() as Map<String, dynamic>?;
        final currentMemberCount = currentData?['memberCount'] as int? ?? 0;
        
        if (currentMemberCount > 0) {
          await chatRoomRef.update({
            'memberCount': FieldValue.increment(-1),
          });
        }
      }
      // 문서가 존재하지 않으면 아무 작업하지 않음
    } catch (e) {
      // 멤버 수 감소 실패
    }
  }

  List<Message> parseMessages(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList();
  }

  ChatRoom? parseChatRoom(DocumentSnapshot doc) {
    if (!doc.exists) return null;
    return ChatRoom.fromFirestore(doc);
  }

  /// roomId에서 열차 ID 추출 (예: "0460_1호선" -> "0460")
  String _extractTrainId(String roomId) {
    final parts = roomId.split('_');
    return parts.isNotEmpty ? parts[0] : roomId;
  }

  /// roomId에서 지하철 노선 추출 (예: "0460_1호선" -> "1호선")
  String _extractSubwayLine(String roomId) {
    final parts = roomId.split('_');
    return parts.length > 1 ? parts[1] : '알 수 없는 노선';
  }

  /// 채팅방 이름 생성
  String _generateRoomName(String roomId) {
    final trainId = _extractTrainId(roomId);
    final subwayLine = _extractSubwayLine(roomId);
    return '$subwayLine $trainId호 열차';
  }

  /// 채팅방 설명 생성
  String _generateRoomDescription(String roomId) {
    final trainId = _extractTrainId(roomId);
    final subwayLine = _extractSubwayLine(roomId);
    return '$subwayLine $trainId호 열차에 탑승한 승객들의 채팅방입니다.';
  }
}