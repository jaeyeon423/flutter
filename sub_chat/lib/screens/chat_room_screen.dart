import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import '../services/chat_service.dart';
import '../services/location_service.dart';
import '../services/current_room_service.dart';
import '../widgets/message_bubble.dart';
import '../widgets/enhanced_message_input.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/user_status_indicator.dart';

class ChatRoomScreen extends StatefulWidget {
  final String roomId;

  const ChatRoomScreen({super.key, required this.roomId});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final AuthService _authService = AuthService();
  final ChatService _chatService = ChatService();
  final LocationService _locationService = LocationService();
  final CurrentRoomService _currentRoomService = CurrentRoomService.instance;
  final ScrollController _scrollController = ScrollController();

  bool _isSending = false;
  bool _isTrainChatRoom = false;
  bool _isLeavingRoom = false; // 방 나가기 상태 추적

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
    // 예상치 못한 종료인 경우 멤버 수 감소
    if (!_isLeavingRoom) {
      debugPrint('[CHAT_ROOM] ⚠️ 예상치 못한 dispose 발생, 멤버 수 정리');
      _chatService.decrementMemberCount(widget.roomId).catchError((e) {
        debugPrint('[CHAT_ROOM] ❌ dispose 시 멤버 수 감소 실패: $e');
      });
      // 환승이 아니라 뒤로가기인 경우 채팅방 정보 유지
      debugPrint('[CHAT_ROOM] 🔙 뒤로가기로 간주, 채팅방 정보 유지');
    } else {
      debugPrint('[CHAT_ROOM] ✅ 정상적인 방 나가기로 dispose');
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
      
      // 현재 채팅방 정보 저장
      final parts = widget.roomId.split('_');
      if (parts.length >= 2) {
        final trainNo = parts[0];
        final subwayLine = parts[1];
        await _currentRoomService.setCurrentRoom(
          roomId: widget.roomId,
          roomName: '$subwayLine $trainNo호',
          trainId: trainNo,
          subwayLine: subwayLine,
        );
      } else {
        await _currentRoomService.setCurrentRoom(
          roomId: widget.roomId,
          roomName: '채팅방',
        );
      }
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


  Widget _buildSimpleTitle() {
    final parts = widget.roomId.split('_');
    if (parts.length >= 2) {
      final trainNo = parts[0];
      final subwayLine = parts[1];
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$subwayLine $trainNo호'),
          const SizedBox(width: 8),
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
        ],
      );
    }
    return const Text('채팅');
  }

  Widget _buildAppBarMenu() {
    final user = _authService.currentUser;
    
    return StreamBuilder<DocumentSnapshot>(
      stream: _chatService.getChatRoom(widget.roomId),
      builder: (context, snapshot) {
        final memberCount = snapshot.hasData && snapshot.data!.data() != null
            ? ((snapshot.data!.data() as Map<String, dynamic>)['memberCount'] as int?) ?? 0
            : 0;

        return PopupMenuButton<String>(
          icon: Stack(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  (user?.displayName?.isNotEmpty == true)
                      ? user!.displayName!.substring(0, 1).toUpperCase()
                      : 'U',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              if (user != null)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: UserStatusIndicator(userId: user.uid, size: 10),
                ),
            ],
          ),
          itemBuilder: (context) => [
            // 프로필 정보 (비활성)
            PopupMenuItem<String>(
              enabled: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, size: 20),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            user?.displayName ?? '사용자',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            user?.email ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '현재 접속자: $memberCount명',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const PopupMenuDivider(),
            // 채팅방 정보
            const PopupMenuItem<String>(
              value: 'info',
              child: Row(
                children: [
                  Icon(Icons.info_outline),
                  SizedBox(width: 8),
                  Text('채팅방 정보'),
                ],
              ),
            ),
            // 환승 (나가기)
            const PopupMenuItem<String>(
              value: 'leave',
              child: Row(
                children: [
                  Icon(Icons.transfer_within_a_station, color: Colors.orange),
                  SizedBox(width: 8),
                  Text('환승', style: TextStyle(color: Colors.orange)),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 'info':
                _showChatRoomInfo(memberCount);
                break;
              case 'leave':
                _showLeaveChatRoomDialog();
                break;
            }
          },
        );
      },
    );
  }

  void _showChatRoomInfo(int memberCount) {
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
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // 기본 뒤로 가기 동작 방지
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          // 뒤로 가기 시 채팅방에서 나가고 채팅방 리스트로 돌아가기
          await _handleBackToList();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: _buildSimpleTitle(),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _handleBackToList,
            tooltip: '뒤로가기',
          ),
          actions: [
            _buildAppBarMenu(),
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

                      final isConsecutive =
                          nextMessage != null &&
                          nextMessage.senderId == message.senderId &&
                          message.timestamp
                                  .difference(nextMessage.timestamp)
                                  .inMinutes <
                              5;

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

  /// 채팅방 나가기 확인 다이얼로그 표시
  Future<void> _showLeaveChatRoomDialog() async {
    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.transfer_within_a_station, color: Colors.orange),
              SizedBox(width: 8),
              Text('환승'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('현재 채팅방에서 나가시겠습니까?'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.orange.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '환승 안내',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '• 채팅방을 나간 후 채팅방 리스트에서 \n   새로운 열차 채팅방에 입장할 수 있습니다.',
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('취소'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(true),
              icon: const Icon(Icons.transfer_within_a_station, size: 18),
              label: const Text('환승하기'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );

    if (shouldLeave == true) {
      await _leaveChatRoom();
    }
  }

  /// 채팅방 나가기 로직 처리
  Future<void> _leaveChatRoom() async {
    try {
      // 버그 및 디버깅용 로깅
      debugPrint('[CHAT_ROOM] 🚇 채팅방 나가기 시작: ${widget.roomId}');
      _isLeavingRoom = true; // 환승 상태 표시

      // 지하철 채팅방인 경우 위치 서비스에서 해제
      if (_isTrainChatRoom) {
        _locationService.exitChatRoom();
        debugPrint('[CHAT_ROOM] 📍 위치 서비스에서 채팅방 해제');
      }

      // 채팅방 멤버 수 감소
      await _chatService.decrementMemberCount(widget.roomId);
      debugPrint('[CHAT_ROOM] 👥 멤버 수 감소 완료');

      // 현재 채팅방 정보 삭제 (환승이므로)
      await _currentRoomService.exitCurrentRoom();
      debugPrint('[CHAT_ROOM] 🏠 현재 채팅방 정보 삭제 완료');

      // 채팅방 리스트로 돌아가기 (메인 네비게이션으로)
      if (mounted) {
        Navigator.of(context).pop();
        debugPrint('[CHAT_ROOM] 🔄 채팅방 리스트로 이동 완료');
      }

      // 성공 메시지 표시
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.transfer_within_a_station, color: Colors.white),
                SizedBox(width: 8),
                Text('환승이 완료되었습니다. 새로운 열차를 선택해주세요.'),
              ],
            ),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      debugPrint('[CHAT_ROOM] ❌ 채팅방 나가기 실패: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('채팅방 나가기 중 오류가 발생했습니다: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleBackToList() async {
    try {
      debugPrint('[CHAT_ROOM] 🔙 뒤로가기 버튼 눌러짐: ${widget.roomId}');
      
      // 지하철 채팅방에서 나가기 (위치 서비스에서 해제)
      if (_isTrainChatRoom) {
        _locationService.exitChatRoom();
      }
      
      // 채팅방 멤버 수 감소
      await _chatService.decrementMemberCount(widget.roomId);
      debugPrint('[CHAT_ROOM] 👥 멤버 수 감소 완료 (뒤로가기)');
      
      // 뒤로가기이므로 채팅방 정보 유지 (삭제하지 않음)
      debugPrint('[CHAT_ROOM] 🏠 뒤로가기이므로 채팅방 정보 유지');
      
      // 예상치 못한 dispose 방지
      _isLeavingRoom = true;
      
      // 채팅방 리스트로 돌아가기
      if (mounted) {
        Navigator.of(context).pop(true); // 뒤로가기로 돌아갔음을 알림
      }
    } catch (e) {
      debugPrint('[CHAT_ROOM] ❌ 뒤로가기 실패: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('채팅방 나가기 중 오류가 발생했습니다: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

}
