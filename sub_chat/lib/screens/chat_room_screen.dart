import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import '../services/chat_service.dart';
import '../services/location_service.dart';
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
  final LocationService _locationService = LocationService();
  final ScrollController _scrollController = ScrollController();
  
  bool _isSending = false;
  bool _isTrainChatRoom = false;

  @override
  void initState() {
    super.initState();
    _checkIfTrainChatRoom();
    _initializeChatRoom();
  }

  @override
  void dispose() {
    // 지하철 채팅방을 나갈 때 위치 서비스에서 해제
    if (_isTrainChatRoom) {
      _locationService.exitChatRoom();
    }
    _scrollController.dispose();
    super.dispose();
  }

  void _checkIfTrainChatRoom() {
    // 모든 채팅방이 지하철 채팅방임 (trainNo_subwayLine 형식)
    _isTrainChatRoom = widget.roomId.contains('_');
  }

  Future<void> _initializeChatRoom() async {
    try {
      await _chatService.initializeChatRoom();
      await _chatService.incrementMemberCount(widget.roomId);
    } catch (e) {
      // 채팅방 초기화 실패
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
    // 모든 채팅방이 지하철 채팅방이므로 roomId를 파싱해서 표시
    final parts = widget.roomId.split('_');
    if (parts.length >= 2) {
      final trainNo = parts[0];
      final subwayLine = parts[1];
      return '$subwayLine $trainNo호';
    }
    return '지하철 채팅';
  }

  Widget _buildTrainChatAppBarTitle() {
    final parts = widget.roomId.split('_');
    if (parts.length >= 2) {
      final trainNo = parts[0];
      final subwayLine = parts[1];
      
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$subwayLine $trainNo호',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                'LIVE',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      );
    }
    
    return Text(_getRoomTitle());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 뒤로 가기 시 채팅방 리스트로 돌아가지 않고 직접 로그아웃 처리
        await _handleBackPress();
        return false; // 기본 뒤로 가기 동작 방지
      },
      child: Scaffold(
        appBar: AppBar(
          title: _buildTrainChatAppBarTitle(),
          leading: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleBackPress,
            tooltip: '로그아웃',
          ),
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
                          const Text(
                            '같은 지하철에 탑승한 사용자들과의 채팅방입니다.\n열차와 100m 이상 떨어지면 자동으로 나가게 됩니다.',
                          ),
                          const SizedBox(height: 8),
                          Text('현재 접속자: $memberCount명'),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                '실시간 위치 기반 채팅 (15분마다 체크)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
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
      ),
    );
  }

  Future<void> _handleBackPress() async {
    // 로그아웃 확인 대화상자 표시
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('앱 종료'),
          content: const Text('채팅방을 나가고 로그아웃하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('로그아웃'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      try {
        // 채팅방에서 나가기
        if (_isTrainChatRoom) {
          _locationService.exitChatRoom();
        }
        await _chatService.decrementMemberCount(widget.roomId);
        
        // 로그아웃 처리
        await _authService.signOut();
        
        // 로그인 화면으로 이동 (모든 화면 제거)
        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/login',
            (route) => false,
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('로그아웃 중 오류가 발생했습니다: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}