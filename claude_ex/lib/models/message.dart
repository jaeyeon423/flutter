class Message {
  final String id;
  final String content;
  final String senderId;
  final String? senderName;
  final DateTime timestamp;
  final MessageType type;

  const Message({
    required this.id,
    required this.content,
    required this.senderId,
    this.senderName,
    required this.timestamp,
    this.type = MessageType.text,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      senderId: map['senderId'] ?? '',
      senderName: map['senderName'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] ?? 0),
      type: MessageType.values.firstWhere(
        (e) => e.toString().split('.').last == (map['type'] ?? 'text'),
        orElse: () => MessageType.text,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'senderId': senderId,
      'senderName': senderName,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'type': type.toString().split('.').last,
    };
  }

  Message copyWith({
    String? id,
    String? content,
    String? senderId,
    String? senderName,
    DateTime? timestamp,
    MessageType? type,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
    );
  }
}

enum MessageType {
  text,
  image,
  file,
}