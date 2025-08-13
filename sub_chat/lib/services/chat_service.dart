import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/message_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getMessages(String roomId) {
    debugPrint('[FIRESTORE] 💬 메시지 스트림 구독 시작: $roomId');
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
    if (text.trim().isEmpty) {
      debugPrint('[FIRESTORE] ⚠️ 빈 메시지 전송 시도 차단');
      return;
    }

    debugPrint('[FIRESTORE] 📤 메시지 전송 시작: $roomId, 길이: ${text.trim().length}');
    final message = Message(
      id: '',
      roomId: roomId,
      text: text.trim(),
      senderId: senderId,
      senderName: senderName,
      timestamp: DateTime.now(),
    );

    final stopwatch = Stopwatch()..start();
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
      stopwatch.stop();
      debugPrint(
        '[FIRESTORE] ✅ 메시지 전송 성공: $roomId (${stopwatch.elapsedMilliseconds}ms)',
      );
    } catch (e) {
      stopwatch.stop();
      debugPrint(
        '[FIRESTORE] ❌ 메시지 전송 실패: $roomId (${stopwatch.elapsedMilliseconds}ms) - $e',
      );
      throw Exception('메시지 전송 실패: ${e.toString()}');
    }
  }

  Stream<DocumentSnapshot> getChatRoom(String roomId) {
    debugPrint('[FIRESTORE] 🏠 채팅방 정보 스트림 구독: $roomId');
    return _firestore.collection('chatRooms').doc(roomId).snapshots();
  }

  Future<void> initializeChatRoom() async {
    debugPrint('[FIRESTORE] 🏗️ 채팅방 초기화 시작');
    const roomId = 'general';
    final chatRoomRef = _firestore.collection('chatRooms').doc(roomId);

    try {
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
        debugPrint('[FIRESTORE] ✅ 일반 채팅방 생성 완료');
      } else {
        debugPrint('[FIRESTORE] ℹ️ 일반 채팅방 이미 존재함');
      }
    } catch (e) {
      debugPrint('[FIRESTORE] ❌ 채팅방 초기화 실패: $e');
    }
  }

  Future<void> incrementMemberCount(String roomId) async {
    debugPrint('[FIRESTORE] 👥 멤버 수 증가 시작: $roomId');
    try {
      final chatRoomRef = _firestore.collection('chatRooms').doc(roomId);
      final chatRoomDoc = await chatRoomRef.get();

      if (chatRoomDoc.exists) {
        // 기존 채팅방 멤버 수 증가
        final currentData = chatRoomDoc.data();
        final currentCount = currentData?['memberCount'] as int? ?? 0;
        await chatRoomRef.update({
          'memberCount': FieldValue.increment(1),
          'updatedAt': FieldValue.serverTimestamp(),
        });
        debugPrint(
          '[FIRESTORE] ✅ 멤버 수 증가: $roomId ($currentCount → ${currentCount + 1})',
        );
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
        debugPrint('[FIRESTORE] 🆕 새 채팅방 생성: $roomName (멤버 1명)');
      }
    } catch (e) {
      debugPrint('[FIRESTORE] ❌ 멤버 수 증가 실패: $roomId - $e');
      throw Exception('멤버 수 증가 실패: ${e.toString()}');
    }
  }

  Future<void> decrementMemberCount(String roomId) async {
    debugPrint('[FIRESTORE] 👥 멤버 수 감소 시작: $roomId');
    try {
      final chatRoomRef = _firestore.collection('chatRooms').doc(roomId);
      final chatRoomDoc = await chatRoomRef.get();

      if (chatRoomDoc.exists) {
        final currentData = chatRoomDoc.data();
        final currentMemberCount = currentData?['memberCount'] as int? ?? 0;

        if (currentMemberCount > 0) {
          await chatRoomRef.update({
            'memberCount': FieldValue.increment(-1),
            'updatedAt': FieldValue.serverTimestamp(),
          });
          debugPrint(
            '[FIRESTORE] ✅ 멤버 수 감소: $roomId ($currentMemberCount → ${currentMemberCount - 1})',
          );
        } else {
          debugPrint('[FIRESTORE] ⚠️ 멤버 수가 이미 0임: $roomId');
        }
      } else {
        debugPrint('[FIRESTORE] ⚠️ 채팅방이 존재하지 않음: $roomId');
      }
    } catch (e) {
      debugPrint('[FIRESTORE] ❌ 멤버 수 감소 실패: $roomId - $e');
      // 멤버 수 감소는 중요하지 않으므로 예외를 던지지 않음
    }
  }

  List<Message> parseMessages(QuerySnapshot snapshot) {
    final messageCount = snapshot.docs.length;
    debugPrint('[FIRESTORE] 📄 메시지 파싱: $messageCount개 메시지');
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
