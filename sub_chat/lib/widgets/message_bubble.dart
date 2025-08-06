import 'package:flutter/material.dart';
import '../models/message_model.dart';
import '../services/auth_service.dart';
import 'user_status_indicator.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool showAvatar;
  final bool isConsecutive;

  const MessageBubble({
    super.key,
    required this.message,
    this.showAvatar = true,
    this.isConsecutive = false,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;
    final isFromCurrentUser = message.senderId == currentUser?.uid;
    final theme = Theme.of(context);

    final semanticLabel = isFromCurrentUser
        ? '내가 보낸 메시지: ${message.text}, ${_formatTime(message.timestamp)}'
        : '${message.senderName}이 보낸 메시지: ${message.text}, ${_formatTime(message.timestamp)}';

    return Semantics(
      label: semanticLabel,
      child: Container(
        margin: EdgeInsets.only(
          top: isConsecutive ? 2 : 8,
          bottom: 2,
          left: 16,
          right: 16,
        ),
        child: Row(
          mainAxisAlignment: isFromCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isFromCurrentUser) ...[
              _buildAvatar(context, isFromCurrentUser),
              const SizedBox(width: 8),
            ],

            Flexible(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                child: Column(
                  crossAxisAlignment: isFromCurrentUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    if (!isFromCurrentUser && !isConsecutive) ...[
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 4),
                        child: Text(
                          message.senderName,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getUserColor(message.senderId),
                          ),
                        ),
                      ),
                    ],

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        gradient: isFromCurrentUser
                            ? LinearGradient(
                                colors: [
                                  theme.primaryColor,
                                  theme.primaryColor.withValues(alpha: 0.8),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
                        color: isFromCurrentUser
                            ? null
                            : theme.brightness == Brightness.dark
                            ? Colors.grey[800]
                            : Colors.grey[100],
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(18),
                          topRight: const Radius.circular(18),
                          bottomLeft: isFromCurrentUser
                              ? const Radius.circular(18)
                              : const Radius.circular(4),
                          bottomRight: isFromCurrentUser
                              ? const Radius.circular(4)
                              : const Radius.circular(18),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.text,
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.4,
                              color: isFromCurrentUser
                                  ? Colors.white
                                  : theme.brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _formatTime(message.timestamp),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isFromCurrentUser
                                      ? Colors.white.withValues(alpha: 0.8)
                                      : Colors.grey[500],
                                ),
                              ),
                              if (isFromCurrentUser) ...[
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.done,
                                  size: 12,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (isFromCurrentUser) ...[
              const SizedBox(width: 8),
              _buildAvatar(context, isFromCurrentUser),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, bool isFromCurrentUser) {
    if (!showAvatar || isConsecutive) {
      return SizedBox(width: isFromCurrentUser ? 32 : 32);
    }

    return Stack(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: isFromCurrentUser
                  ? [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withValues(alpha: 0.7),
                    ]
                  : [
                      _getUserColor(message.senderId),
                      _getUserColor(message.senderId).withValues(alpha: 0.7),
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              message.senderName.isNotEmpty
                  ? message.senderName.substring(0, 1).toUpperCase()
                  : 'U',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          right: 0,
          child: UserStatusIndicator(userId: message.senderId, size: 10),
        ),
      ],
    );
  }

  Color _getUserColor(String userId) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
    ];

    return colors[userId.hashCode % colors.length];
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return '어제 ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${dateTime.month}/${dateTime.day} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}
