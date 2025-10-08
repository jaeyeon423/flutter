
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import '../models/message_model.dart';

class ChatService {
  final FirebaseDatabase _database = FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: 'https://chat-app-8c599-default-rtdb.asia-southeast1.firebasedatabase.app');

  Stream<List<Message>> getMessages(String roomId) {
    debugPrint('[RTDB] 💬 getMessages 호출됨: $roomId');
    final messagesRef = _database.ref('chatRooms/$roomId/messages');
    final controller = StreamController<List<Message>>();

    final subscription = messagesRef.orderByChild('timestamp').limitToLast(100).onValue.listen(
      (event) {
        debugPrint('[RTDB] 💬 onValue 이벤트 수신');
        if (event.snapshot.value == null) {
          debugPrint('[RTDB] 📄 메시지 없음: $roomId');
          controller.add([]);
          return;
        }
        
        final messages = <Message>[];
        try {
          final messagesMap = Map<String, dynamic>.from(event.snapshot.value as Map);
          messagesMap.forEach((key, value) {
            final messageData = Map<String, dynamic>.from(value as Map);
            messages.add(Message.fromRtdb(key, messageData));
          });
        } catch (e) {
          debugPrint('[RTDB] 📄 메시지 파싱 오류: $e');
          controller.addError(Exception('메시지 데이터 파싱에 실패했습니다.'));
          return;
        }

        messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        
        debugPrint('[RTDB] 📄 메시지 파싱 완료: ${messages.length}개');
        controller.add(messages);
      },
      onError: (error) {
        debugPrint('[RTDB] 💬 스트림 오류: $error');
        controller.addError(error);
      }
    );

    // 컨트롤러가 취소될 때 리스너도 함께 정리
    controller.onCancel = () {
      debugPrint('[RTDB] 💬 메시지 스트림 구독 취소: $roomId');
      subscription.cancel();
    };

    return controller.stream;
  }

  Future<void> sendMessage({
    required String roomId,
    required String text,
    required String senderId,
    required String senderName,
  }) async {
    if (text.trim().isEmpty) {
      debugPrint('[RTDB] ⚠️ 빈 메시지 전송 시도 차단');
      return;
    }

    debugPrint('[RTDB] 📤 메시지 전송 시작: $roomId, 길이: ${text.trim().length}');
    
    final message = Message(
      id: '', // RTDB에서는 push key가 id 역할을 하므로 비워둠
      roomId: roomId,
      text: text.trim(),
      senderId: senderId,
      senderName: senderName,
      timestamp: DateTime.now(),
    );

    final stopwatch = Stopwatch()..start();
    try {
      final messagesRef = _database.ref('chatRooms/$roomId/messages');
      final chatRoomRef = _database.ref('chatRooms/$roomId/metadata');

      // 1. 새 메시지 추가 (push로 고유 키 생성)
      await messagesRef.push().set(message.toRtdb());

      // 2. 채팅방 메타데이터 업데이트 (lastMessage 등)
      await chatRoomRef.update({
        'lastMessage': {
          'text': message.text,
          'senderId': message.senderId,
          'senderName': message.senderName,
          'timestamp': ServerValue.timestamp,
        },
        'updatedAt': ServerValue.timestamp,
      });

      stopwatch.stop();
      debugPrint('[RTDB] ✅ 메시지 전송 성공: $roomId (${stopwatch.elapsedMilliseconds}ms)');
    } catch (e) {
      stopwatch.stop();
      debugPrint('[RTDB] ❌ 메시지 전송 실패: $roomId (${stopwatch.elapsedMilliseconds}ms) - $e');
      throw Exception('메시지 전송 실패: ${e.toString()}');
    }
  }

  Stream<DataSnapshot> getChatRoom(String roomId) {
    debugPrint('[RTDB] 🏠 채팅방 정보 스트림 구독: $roomId');
    return _database.ref('chatRooms/$roomId/metadata').onValue.map((event) => event.snapshot);
  }

  Future<void> initializeChatRoom() async {
    debugPrint('[RTDB] 🏗️ 채팅방 초기화 시작');
    const roomId = 'general';
    final chatRoomRef = _database.ref('chatRooms/$roomId/metadata');

    try {
      final snapshot = await chatRoomRef.get();
      if (!snapshot.exists) {
        await chatRoomRef.set({
          'name': '일반 채팅',
          'description': '모든 사용자가 참여하는 채팅방',
          'createdAt': ServerValue.timestamp,
          'memberCount': 0,
          'lastMessage': null,
          'updatedAt': ServerValue.timestamp,
        });
        debugPrint('[RTDB] ✅ 일반 채팅방 생성 완료');
      } else {
        debugPrint('[RTDB] ℹ️ 일반 채팅방 이미 존재함');
      }
    } catch (e) {
      debugPrint('[RTDB] ❌ 채팅방 초기화 실패: $e');
    }
  }

  Future<void> incrementMemberCount(String roomId) async {
    debugPrint('[RTDB] 👥 멤버 수 증가 시작: $roomId');
    final metadataRef = _database.ref('chatRooms/$roomId/metadata');
    
    try {
      final snapshot = await metadataRef.get();
      if (snapshot.exists) {
        await metadataRef.update({
          'memberCount': ServerValue.increment(1),
          'updatedAt': ServerValue.timestamp,
        });
        final newCount = ((snapshot.value as Map?)?['memberCount'] ?? 0) + 1;
        debugPrint('[RTDB] ✅ 멤버 수 증가: $roomId (-> $newCount)');
      } else {
        // 새 채팅방 생성
        final roomName = _generateRoomName(roomId);
        await metadataRef.set({
          'name': roomName,
          'description': _generateRoomDescription(roomId),
          'type': 'train',
          'trainId': _extractTrainId(roomId),
          'subwayLine': _extractSubwayLine(roomId),
          'createdAt': ServerValue.timestamp,
          'memberCount': 1,
          'lastMessage': null,
          'updatedAt': ServerValue.timestamp,
        });
        debugPrint('[RTDB] 🆕 새 채팅방 생성: $roomName (멤버 1명)');
      }
    } catch (e) {
      debugPrint('[RTDB] ❌ 멤버 수 증가 실패: $roomId - $e');
      throw Exception('멤버 수 증가 실패: ${e.toString()}');
    }
  }

  Future<void> decrementMemberCount(String roomId) async {
    debugPrint('[RTDB] 👥 멤버 수 감소 시작: $roomId');
    final metadataRef = _database.ref('chatRooms/$roomId/metadata');
    
    try {
      final snapshot = await metadataRef.get();
      if (snapshot.exists) {
        final currentCount = (snapshot.value as Map?)?['memberCount'] ?? 0;
        if (currentCount > 0) {
          await metadataRef.update({
            'memberCount': ServerValue.increment(-1),
            'updatedAt': ServerValue.timestamp,
          });
          debugPrint('[RTDB] ✅ 멤버 수 감소: $roomId (-> ${currentCount - 1})');
        } else {
          debugPrint('[RTDB] ⚠️ 멤버 수가 이미 0임: $roomId');
        }
      } else {
        debugPrint('[RTDB] ⚠️ 채팅방이 존재하지 않음: $roomId');
      }
    } catch (e) {
      debugPrint('[RTDB] ❌ 멤버 수 감소 실패: $roomId - $e');
    }
  }

  // Helper methods for parsing room details from ID
  String _extractTrainId(String roomId) {
    final parts = roomId.split('_');
    return parts.isNotEmpty ? parts[0] : roomId;
  }

  String _extractSubwayLine(String roomId) {
    final parts = roomId.split('_');
    return parts.length > 1 ? parts[1] : '알 수 없는 노선';
  }

  String _generateRoomName(String roomId) {
    final trainId = _extractTrainId(roomId);
    final subwayLine = _extractSubwayLine(roomId);
    return '$subwayLine $trainId호 열차';
  }

  String _generateRoomDescription(String roomId) {
    final trainId = _extractTrainId(roomId);
    final subwayLine = _extractSubwayLine(roomId);
    return '$subwayLine $trainId호 열차에 탑승한 승객들의 채팅방입니다.';
  }
}
