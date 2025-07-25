import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/message.dart';
import '../models/chat_room.dart';

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get currentUserId => _auth.currentUser?.uid;
  String? get currentUserEmail => _auth.currentUser?.email;

  // 채팅방 생성
  Future<String> createChatRoom(String name, List<String> participants) async {
    final chatRoom = ChatRoom(
      id: '',
      name: name,
      participants: participants,
      createdAt: DateTime.now(),
    );

    final docRef = await _firestore.collection('chatRooms').add(chatRoom.toMap());
    return docRef.id;
  }

  // 채팅방 목록 스트림
  Stream<List<ChatRoom>> getChatRooms() {
    if (currentUserId == null) return Stream.value([]);

    return _firestore
        .collection('chatRooms')
        .where('participants', arrayContains: currentUserId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatRoom.fromMap({...doc.data(), 'id': doc.id}))
            .toList());
  }

  // 메시지 전송
  Future<void> sendMessage(String chatRoomId, String content) async {
    if (currentUserId == null) return;

    final message = Message(
      id: '',
      content: content,
      senderId: currentUserId!,
      senderName: currentUserEmail,
      timestamp: DateTime.now(),
    );

    final batch = _firestore.batch();

    // 메시지 추가
    final messageRef = _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .doc();
    
    batch.set(messageRef, message.toMap());

    // 채팅방 마지막 메시지 업데이트
    final chatRoomRef = _firestore.collection('chatRooms').doc(chatRoomId);
    try {
      batch.update(chatRoomRef, {
        'lastMessage': content,
        'lastMessageTime': message.timestamp.millisecondsSinceEpoch,
      });
    } catch (e) {
      // 문서가 존재하지 않으면 생성
      batch.set(chatRoomRef, {
        'lastMessage': content,
        'lastMessageTime': message.timestamp.millisecondsSinceEpoch,
        'participants': [currentUserId!],
        'name': '전체 채팅',
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      }, SetOptions(merge: true));
    }

    await batch.commit();
  }

  // 메시지 스트림
  Stream<List<Message>> getMessages(String chatRoomId) {
    return _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Message.fromMap({...doc.data(), 'id': doc.id}))
            .toList());
  }

  // 전역 채팅방 ID (모든 사용자가 공유)
  static const String _globalChatRoomId = 'global_chat_room';

  // 전역 채팅방 생성 또는 참여
  Future<String> createDefaultChatRoom() async {
    if (currentUserId == null) return '';

    try {
      // 기존 개별 채팅방들 정리 (한 번만 실행)
      await _cleanupOldChatRooms();
      
      // 전역 채팅방이 존재하는지 확인
      final globalRoomDoc = await _firestore
          .collection('chatRooms')
          .doc(_globalChatRoomId)
          .get();

      if (globalRoomDoc.exists) {
        // 이미 존재하면 현재 사용자를 참가자에 추가 (중복 방지)
        await _addUserToGlobalChatRoom();
        return _globalChatRoomId;
      } else {
        // 전역 채팅방이 없으면 생성
        await _createGlobalChatRoom();
        return _globalChatRoomId;
      }
    } catch (e) {
      // 로그는 개발 시에만 사용, 프로덕션에서는 적절한 에러 처리 필요
      debugPrint('Error creating/joining global chat room: $e');
      return '';
    }
  }

  // 기존 개별 채팅방들 정리 (옵션: 필요시에만 사용)
  Future<void> _cleanupOldChatRooms() async {
    if (currentUserId == null) return;

    try {
      // 현재 사용자가 참여한 개별 채팅방들 찾기 (전역 채팅방 제외)
      final oldRooms = await _firestore
          .collection('chatRooms')
          .where('participants', arrayContains: currentUserId)
          .get();

      final batch = _firestore.batch();
      
      for (final doc in oldRooms.docs) {
        // 전역 채팅방이 아닌 경우에만 삭제
        if (doc.id != _globalChatRoomId) {
          final data = doc.data();
          final participants = List<String>.from(data['participants'] ?? []);
          
          // 참가자가 1명이면 완전 삭제, 여러 명이면 현재 사용자만 제거
          if (participants.length <= 1) {
            batch.delete(doc.reference);
          } else {
            batch.update(doc.reference, {
              'participants': FieldValue.arrayRemove([currentUserId!]),
            });
          }
        }
      }
      
      await batch.commit();
    } catch (e) {
      debugPrint('Error cleaning up old chat rooms: $e');
    }
  }

  // 전역 채팅방 생성
  Future<void> _createGlobalChatRoom() async {
    if (currentUserId == null) return;

    final globalChatRoom = ChatRoom(
      id: _globalChatRoomId,
      name: '전체 채팅',
      participants: [currentUserId!],
      createdAt: DateTime.now(),
    );

    await _firestore
        .collection('chatRooms')
        .doc(_globalChatRoomId)
        .set(globalChatRoom.toMap());
  }

  // 현재 사용자를 전역 채팅방에 추가
  Future<void> _addUserToGlobalChatRoom() async {
    if (currentUserId == null) return;

    await _firestore
        .collection('chatRooms')
        .doc(_globalChatRoomId)
        .update({
      'participants': FieldValue.arrayUnion([currentUserId!]),
    });
  }
}