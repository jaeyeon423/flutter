import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import '../services/chat_service.dart';
import '../models/message_model.dart';
import '../widgets/message_bubble.dart';
import '../widgets/enhanced_message_input.dart';
import '../widgets/loading_overlay.dart';

class ChatRoomScreen extends StatefulWidget {
  final String roomId;
  
  const ChatRoomScreen({
    super.key,
    required this.roomId,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final AuthService _authService = AuthService();
  final ChatService _chatService = ChatService();
  final ScrollController _scrollController = ScrollController();
  
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _initializeChatRoom();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _initializeChatRoom() async {
    try {
      await _chatService.initializeChatRoom();
      await _chatService.incrementMemberCount(widget.roomId);
    } catch (e) {
      print('채팅방 초기화 실패: $e');
    }
  }

  Future<void> _sendMessage(String text) async {
    final user = _authService.currentUser;
    if (user == null) return;

    setState(() {
      _isSending = true;
    });

    try {
      await _chatService.sendMessage(
        roomId: widget.roomId,
        text: text,
        senderId: user.uid,
        senderName: user.displayName ?? '익명',
      );
      
      _scrollToBottom();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('메시지 전송 실패: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  String _getRoomTitle() {
    switch (widget.roomId) {
      case 'general':
        return '일반 채팅';
      default:
        return '채팅방';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getRoomTitle()),
        actions: [
          StreamBuilder<DocumentSnapshot>(
            stream: _chatService.getChatRoom(widget.roomId),
            builder: (context, snapshot) {
              final memberCount = snapshot.hasData && snapshot.data!.data() != null
                  ? ((snapshot.data!.data() as Map<String, dynamic>)['memberCount'] as int?) ?? 0
                  : 0;
              
              return IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(_getRoomTitle()),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('모든 사용자가 참여하는 채팅방입니다.'),
                          const SizedBox(height: 8),
                          Text('현재 접속자: $memberCount명'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('확인'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 메시지 리스트
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _chatService.getMessages(widget.roomId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return ErrorStateWidget(
                    message: '메시지를 불러오는 중 오류가 발생했습니다.\n${snapshot.error}',
                    onRetry: () {
                      setState(() {});
                    },
                    icon: Icons.chat_bubble_outline,
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text(
                          '메시지를 불러오는 중...',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                final messages = _chatService.parseMessages(snapshot.data!);

                if (messages.isEmpty) {
                  return const EmptyStateWidget(
                    message: '첫 메시지를 보내보세요!\n새로운 대화를 시작해보세요.',
                    icon: Icons.chat_bubble_outline,
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: const EdgeInsets.only(bottom: 8),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final nextMessage = index < messages.length - 1 
                        ? messages[index + 1] 
                        : null;
                    
                    final isConsecutive = nextMessage != null &&
                        nextMessage.senderId == message.senderId &&
                        message.timestamp.difference(nextMessage.timestamp).inMinutes < 5;
                    
                    return MessageBubble(
                      message: message,
                      isConsecutive: isConsecutive,
                    );
                  },
                );
              },
            ),
          ),
          
          // 메시지 입력부
          EnhancedMessageInput(
            onSendMessage: _sendMessage,
            isLoading: _isSending,
            hintText: '메시지를 입력하세요...',
          ),
        ],
      ),
    );
  }
}