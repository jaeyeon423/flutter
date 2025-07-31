import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String roomId;
  final String text;
  final String senderId;
  final String senderName;
  final DateTime timestamp;
  final MessageType type;

  Message({
    required this.id,
    required this.roomId,
    required this.text,
    required this.senderId,
    required this.senderName,
    required this.timestamp,
    this.type = MessageType.text,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return Message(
      id: doc.id,
      roomId: data['roomId'] ?? '',
      text: data['text'] ?? '',
      senderId: data['senderId'] ?? '',
      senderName: data['senderName'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      type: MessageType.values.firstWhere(
        (e) => e.name == data['type'],
        orElse: () => MessageType.text,
      ),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'roomId': roomId,
      'text': text,
      'senderId': senderId,
      'senderName': senderName,
      'timestamp': FieldValue.serverTimestamp(),
      'type': type.name,
    };
  }

  bool get isFromCurrentUser => senderId == senderId;
}

enum MessageType {
  text,
  image,
  file,
}

class ChatRoom {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final int memberCount;
  final Message? lastMessage;

  ChatRoom({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.memberCount,
    this.lastMessage,
  });

  factory ChatRoom.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return ChatRoom(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      memberCount: data['memberCount'] ?? 0,
      lastMessage: data['lastMessage'] != null 
          ? _parseLastMessage(data['lastMessage'])
          : null,
    );
  }

  static Message _parseLastMessage(Map<String, dynamic> data) {
    return Message(
      id: '',
      roomId: '',
      text: data['text'] ?? '',
      senderId: data['senderId'] ?? '',
      senderName: data['senderName'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}