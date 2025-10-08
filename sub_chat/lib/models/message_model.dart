import 'package:firebase_database/firebase_database.dart';

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

  factory Message.fromRtdb(String id, Map<dynamic, dynamic> data) {
    return Message(
      id: id,
      roomId: data['roomId'] ?? '',
      text: data['text'] ?? '',
      senderId: data['senderId'] ?? '',
      senderName: data['senderName'] ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp'] ?? 0),
      type: MessageType.values.firstWhere(
        (e) => e.name == data['type'],
        orElse: () => MessageType.text,
      ),
    );
  }

  Map<String, dynamic> toRtdb() {
    return {
      'roomId': roomId,
      'text': text,
      'senderId': senderId,
      'senderName': senderName,
      'timestamp': ServerValue.timestamp, // RTDB server-side timestamp
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

  factory ChatRoom.fromRtdb(String id, Map<dynamic, dynamic> data) {
    return ChatRoom(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(data['createdAt'] ?? 0),
      memberCount: data['memberCount'] ?? 0,
      lastMessage: data['lastMessage'] != null 
          ? _parseLastMessage(data['lastMessage'])
          : null,
    );
  }

  static Message _parseLastMessage(Map<dynamic, dynamic> data) {
    return Message(
      id: '', // lastMessage doesn't have a separate ID
      roomId: '', // Not needed for the preview
      text: data['text'] ?? '',
      senderId: data['senderId'] ?? '',
      senderName: data['senderName'] ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp'] ?? 0),
    );
  }
}