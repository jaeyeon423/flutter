import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserStatusIndicator extends StatelessWidget {
  final String userId;
  final double size;
  final bool showText;
  
  const UserStatusIndicator({
    super.key,
    required this.userId,
    this.size = 12,
    this.showText = false,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return _buildOfflineIndicator(context);
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final isOnline = userData['isOnline'] ?? false;
        final lastSeen = userData['lastSeen'] as Timestamp?;
        
        if (isOnline) {
          return _buildOnlineIndicator(context);
        } else {
          return _buildOfflineIndicator(context, lastSeen?.toDate());
        }
      },
    );
  }

  Widget _buildOnlineIndicator(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withValues(alpha: 0.3),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
        if (showText) ...[
          const SizedBox(width: 4),
          Text(
            '온라인',
            style: TextStyle(
              color: Colors.green,
              fontSize: size * 0.8,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildOfflineIndicator(BuildContext context, [DateTime? lastSeen]) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
        ),
        if (showText) ...[
          const SizedBox(width: 4),
          Text(
            lastSeen != null ? _getLastSeenText(lastSeen) : '오프라인',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: size * 0.8,
            ),
          ),
        ],
      ],
    );
  }

  String _getLastSeenText(DateTime lastSeen) {
    final now = DateTime.now();
    final difference = now.difference(lastSeen);
    
    if (difference.inMinutes < 1) {
      return '방금 전';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return '오래 전';
    }
  }
}