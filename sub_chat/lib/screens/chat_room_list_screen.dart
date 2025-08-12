import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/location_service.dart';
import '../services/subway_service.dart';
import '../services/current_room_service.dart';
import '../widgets/user_status_indicator.dart';
import 'chat_room_screen.dart';

class ChatRoomListScreen extends StatefulWidget {
  const ChatRoomListScreen({super.key});

  @override
  State<ChatRoomListScreen> createState() => _ChatRoomListScreenState();
}

class _ChatRoomListScreenState extends State<ChatRoomListScreen> {
  final AuthService _authService = AuthService();
  final LocationService _locationService = LocationService();
  final CurrentRoomService _currentRoomService = CurrentRoomService.instance;

  List<TrainPosition> _nearbyTrains = [];
  bool _isLoadingTrains = false;
  @override
  void initState() {
    super.initState();
    _initializeCurrentRoomService();
    _initializeLocationService();
  }

  Future<void> _initializeCurrentRoomService() async {
    try {
      final success = await _currentRoomService.initialize();
      if (!success) {
        debugPrint('[CHAT_LIST] ⚠️ CurrentRoomService 초기화 실패, 메모리 모드로 작동');
      }
    } catch (e) {
      debugPrint('[CHAT_LIST] ❌ CurrentRoomService 초기화 중 오류: $e');
    }
  }

  @override
  void dispose() {
    _locationService.stop();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 채팅방에서 돌아오거나 상태 변경 시 AppBar 새로고침
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<void> _initializeLocationService() async {
    debugPrint('[CHAT_LIST] 📍 위치 서비스 초기화 시작');
    try {
      final success = await _locationService.initialize(
        (position) {
          if (mounted) {
            debugPrint(
              '[CHAT_LIST] 📍 위치 업데이트: ${position.latitude}, ${position.longitude}',
            );
          }
        },
        onNearbyTrainsUpdate: (trains) {
          if (mounted) {
            setState(() {
              _nearbyTrains = trains;
            });
            debugPrint('[CHAT_LIST] 🚇 근처 열차 업데이트: ${trains.length}개');
          }
        },
        onDistanceAlert: (message, isWarning) {
          if (mounted) {
            debugPrint('[CHAT_LIST] ⚠️ 거리 알림: $message (경고: $isWarning)');
            _showDistanceAlert(message, isWarning);
          }
        },
      );

      if (success) {
        debugPrint('[CHAT_LIST] ✅ 위치 서비스 초기화 성공');
        _initializeNearbyTrainsListener();
        _loadNearbyTrains();
      } else {
        debugPrint('[CHAT_LIST] ❌ 위치 서비스 초기화 실패 - 권한 대화상자 표시');
        _showLocationPermissionDialog();
      }
    } catch (e) {
      debugPrint('[CHAT_LIST] ☠️ 위치 서비스 초기화 오류: $e');
    }
  }

  void _initializeNearbyTrainsListener() {
    // 근처 지하철 업데이트 리스너 등록
    _nearbyTrains = _locationService.nearbyTrains;
  }

  Future<void> _loadNearbyTrains({bool forceRefresh = false}) async {
    if (_isLoadingTrains) {
      debugPrint('[CHAT_LIST] ⏰ 이미 열차 로딩 중이므로 건너뜀');
      return;
    }

    debugPrint('[CHAT_LIST] 🔄 근처 열차 로딩 시작 (강제새로고침: $forceRefresh)');
    setState(() {
      _isLoadingTrains = true;
    });

    final stopwatch = Stopwatch()..start();
    try {
      if (forceRefresh) {
        // 강제 새로고침 (캐시 무시)
        await _locationService.forceRefreshNearbyTrains();
        debugPrint('[CHAT_LIST] 🔄 강제 새로고침 완료');
      } else {
        // 일반 새로고침 (캐시 활용)
        await _locationService.refreshNearbyTrains();
        debugPrint('[CHAT_LIST] 🔄 일반 새로고침 완료');
      }

      setState(() {
        _nearbyTrains = _locationService.nearbyTrains;
      });
      stopwatch.stop();
      debugPrint(
        '[CHAT_LIST] ✅ 근처 열차 로딩 성공: ${_nearbyTrains.length}개 (${stopwatch.elapsedMilliseconds}ms)',
      );
    } catch (e) {
      stopwatch.stop();
      debugPrint(
        '[CHAT_LIST] ❌ 근처 지하철 로드 실패 (${stopwatch.elapsedMilliseconds}ms): $e',
      );
    } finally {
      setState(() {
        _isLoadingTrains = false;
      });
    }
  }

  Future<void> _handleLogout() async {
    debugPrint('[CHAT_LIST] 🚪 로그아웃 시작');
    try {
      await _authService.signOut();
      debugPrint('[CHAT_LIST] ✅ 로그아웃 성공');
    } catch (e) {
      debugPrint('[CHAT_LIST] ❌ 로그아웃 실패: $e');
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

  Future<void> _navigateToChatRoom(String roomId, {TrainPosition? train, bool isReconnect = false}) async {
    debugPrint('[CHAT_LIST] 🚇 채팅방 이동: $roomId (재연결: $isReconnect)');
    
    // 재연결이 아닌 경우만 환승 확인
    if (!isReconnect && _currentRoomService.shouldShowTransferConfirmation(roomId)) {
      final shouldTransfer = await _showTransferConfirmationDialog(roomId, train);
      if (shouldTransfer != true) {
        return; // 사용자가 취소하거나 대화상자를 닫은 경우
      }
    }
    
    // 지하철 채팅방의 경우 위치 서비스에 열차 정보 등록
    if (train != null) {
      debugPrint(
        '[CHAT_LIST] 📍 위치 서비스에 열차 등록: ${train.subwayNm} ${train.trainNo}호',
      );
      _locationService.enterChatRoom(train.trainNo!, train.subwayNm!);
    }

    // 채팅방으로 네비게이션
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => ChatRoomScreen(roomId: roomId)),
    );
    
    // 채팅방에서 돌아온 후 상태 새로고침
    if (result == true && mounted) {
      debugPrint('[CHAT_LIST] 🔄 채팅방에서 뒤로가기로 돌아온 후 상태 새로고침');
      setState(() {}); // AppBar 상태 업데이트
    }
    
    debugPrint('[CHAT_LIST] ✅ 채팅방 화면으로 네비게이션 완료');
  }

  Future<void> _showLogoutDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('로그아웃'),
          content: const Text('정말 로그아웃하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleLogout();
              },
              child: const Text('로그아웃'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: _buildAppBarTitle(),
        actions: [
          PopupMenuButton<void>(
            icon: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    (user?.displayName?.isNotEmpty == true)
                        ? user!.displayName!.substring(0, 1).toUpperCase()
                        : 'U',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (user != null)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: UserStatusIndicator(userId: user.uid, size: 12),
                  ),
              ],
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    const Icon(Icons.person),
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
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                onTap: _showLogoutDialog,
                child: const Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 8),
                    Text('로그아웃', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _loadNearbyTrains(forceRefresh: false),
        child: ListView(
          children: [
            // 현재 입장 중인 채팅방 (최상단에 표시)
            _buildCurrentRoomWidget(),

            // 지하철 채팅방 섹션
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.train,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '지하철 채팅방',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Spacer(),
                  if (_isLoadingTrains)
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  else
                    GestureDetector(
                      onTap: () => _loadNearbyTrains(forceRefresh: false),
                      onLongPress: () => _showForceRefreshDialog(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.refresh,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // 임시 채팅방 (위치 상관없이 입장 가능)
            _buildTemporaryChatRoom(),

            const SizedBox(height: 16),

            // 근처 지하철 채팅방 리스트
            if (_nearbyTrains.isNotEmpty)
              ..._buildNearbyTrainChatRooms()
            else if (_isLoadingTrains)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text(
                        '근처 지하철을 찾고 있습니다...',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

            // 근처 지하철이 없을 때 안내 메시지
            if (_nearbyTrains.isEmpty && !_isLoadingTrains)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.train_outlined,
                        size: 60,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '근처에 지하철이 없습니다',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '지하철역 100m 이내로 이동하시면\n해당 열차의 실시간 채팅방이 자동으로 표시됩니다',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.refresh,
                            size: 16,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '새로고침하여 업데이트',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNearbyTrainChatRooms() {
    return _nearbyTrains.map((train) {
      final distance = train.distanceFromUser?.toStringAsFixed(0) ?? '0';
      final lineColor = _getSubwayLineColor(train.subwayNm);
      final directionInfo = _getDirectionInfo(train.updnLine);
      final directionColor = _getDirectionColor(train.updnLine);
      final directionIcon = _getDirectionIcon(train.updnLine);

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: Colors.grey[300]!,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () async => await _navigateToChatRoom(train.chatRoomId, train: train),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                  // 상단: 노선 정보와 방향 배지
                  Row(
                    children: [
                      // 노선 아이콘
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 2,
                            color: lineColor,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _getSubwayLineNumber(train.subwayNm),
                            style: TextStyle(
                              color: lineColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),

                      // 열차 정보 및 방향 표시
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${train.subwayNm} ${train.trainNo}호',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 19,
                                      color: Color(0xFF1A1A1A),
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ),
                                // 방향 표시 배지
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      width: 1.5,
                                      color: directionColor,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        directionIcon,
                                        size: 14,
                                        color: directionColor,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        directionInfo['text']!,
                                        style: TextStyle(
                                          color: directionColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            // 현재 위치와 종착지 정보를 분리하여 표시
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                      children: [
                                        TextSpan(text: '${train.statnNm} → '),
                                        TextSpan(
                                          text: '${train.statnTnm} 행',
                                          style: TextStyle(
                                            color: lineColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  
                  // 구분선
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey[300],
                  ),
                  
                  const SizedBox(height: 16),

                  // 하단: 거리 정보와 입장 버튼
                  Row(
                    children: [
                      // 거리 정보
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 1,
                            color: Colors.green,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.green[700],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${distance}m',
                              style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // 입장 버튼
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 2,
                            color: lineColor,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '채팅 입장',
                              style: TextStyle(
                                color: lineColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: lineColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  /// 현재 입장 중인 채팅방을 최상단에 표시하는 위젯
  Widget _buildCurrentRoomWidget() {
    final currentRoom = _currentRoomService.getCurrentRoom();
    
    if (currentRoom == null) {
      return const SizedBox.shrink(); // 현재 채팅방이 없으면 아무것도 표시하지 않음
    }

    final roomId = currentRoom['roomId'] as String;
    final roomName = currentRoom['roomName'] as String;
    final trainId = currentRoom['trainId'] as String?;
    final subwayLine = currentRoom['subwayLine'] as String?;
    
    // 지하철 채팅방인지 확인
    final isTrainChatRoom = trainId != null && subwayLine != null;
    final lineColor = isTrainChatRoom ? _getSubwayLineColor(subwayLine) : Colors.green;
    
    // 현재 입장중인 열차의 역 정보 찾기
    String displayName = roomName;
    if (isTrainChatRoom) {
      // 현재 열차와 매칭되는 근처 열차 찾기
      try {
        final matchingTrain = _nearbyTrains.firstWhere(
          (train) => train.trainNo == trainId && train.subwayNm == subwayLine,
        );
        displayName = '${subwayLine} ${matchingTrain.statnNm}';
      } catch (e) {
        // 매칭되는 열차를 찾지 못한 경우 기본 표시
        displayName = '${subwayLine} 채팅방';
      }
    }

    return Container(
      margin: const EdgeInsets.all(16),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              width: 2,
              color: Colors.green,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // 상단: 현재 채팅방 표시
                Row(
                  children: [
                    // 상태 아이콘
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 2,
                          color: lineColor,
                        ),
                      ),
                      child: Center(
                        child: isTrainChatRoom
                            ? Text(
                                _getSubwayLineNumber(subwayLine),
                                style: TextStyle(
                                  color: lineColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              )
                            : Icon(
                                Icons.chat,
                                color: lineColor,
                                size: 24,
                              ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // 채팅방 정보
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              const SizedBox(width: 6),
                              const Text(
                                '현재 입장 중',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            displayName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // 구분선
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey[300],
                ),

                const SizedBox(height: 16),

                // 하단: 재입장 버튼
                Row(
                  children: [
                    // 상태 정보
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 1,
                            color: Colors.green,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              size: 16,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '연결된 채팅방',
                              style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // 재입장 버튼
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 2,
                          color: Colors.green,
                        ),
                      ),
                      child: InkWell(
                        onTap: () => _reconnectToCurrentRoom(roomId),
                        borderRadius: BorderRadius.circular(12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.login,
                              size: 18,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '재입장',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 현재 채팅방으로 재입장
  Future<void> _reconnectToCurrentRoom(String roomId) async {
    debugPrint('[CHAT_LIST] 🔄 현재 채팅방 재입장: $roomId');
    
    // 지하철 채팅방인 경우 위치 서비스에서 열차 정보 찾기
    TrainPosition? matchingTrain;
    if (roomId.contains('_')) {
      final parts = roomId.split('_');
      if (parts.length >= 2) {
        final trainNo = parts[0];
        final subwayLine = parts[1];
        
        // 근처 열차 중에서 매칭되는 열차 찾기
        try {
          matchingTrain = _nearbyTrains.firstWhere(
            (train) => train.trainNo == trainNo && train.subwayNm == subwayLine,
          );
        } catch (e) {
          // 매칭되는 열차를 찾지 못한 경우 기본 TrainPosition 생성
          matchingTrain = TrainPosition(
            trainNo: trainNo,
            subwayNm: subwayLine,
          );
          // chatRoomId 속성 설정 (TrainPosition에 getter 추가 필요)
          debugPrint('[CHAT_LIST] ⚠️ 매칭되는 열차를 찾지 못함, 기본 정보로 재입장: $trainNo $subwayLine');
        }
      }
    }
    
    // 재연결 플래그를 true로 설정하여 환승 다이얼로그 표시 안함
    await _navigateToChatRoom(roomId, train: matchingTrain, isReconnect: true);
  }

  Widget _buildAppBarTitle() {
    return const Text('채팅');
  }

  /// 환승 확인 다이얼로그
  Future<bool?> _showTransferConfirmationDialog(String newRoomId, TrainPosition? train) async {
    final currentRoom = _currentRoomService.getCurrentRoom();
    final currentRoomTitle = _currentRoomService.getCurrentRoomTitle() ?? '현재 채팅방';
    
    String newRoomTitle = '새 채팅방';
    if (train != null) {
      newRoomTitle = '${train.subwayNm} ${train.trainNo}호';
    } else if (newRoomId == 'temp_chat_room') {
      newRoomTitle = '임시 채팅방';
    }

    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.transfer_within_a_station, color: Colors.orange),
              SizedBox(width: 8),
              Text('환승 확인'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('현재 "$currentRoomTitle"에 입장중입니다.'),
              const SizedBox(height: 8),
              Text('"$newRoomTitle"로 환승하시겠습니까?'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withValues(alpha: 0.2),
                      blurRadius: 6,
                      offset: const Offset(2, 3),
                    ),
                  ],
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
                      '• 환승: 현재 채팅방에서 완전히 나간 후 새로운 채팅방 입장\n• 뒤로가기: 채팅방 상태를 유지하며 리스트로 이동',
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
  }

  Color _getSubwayLineColor(String? subwayLine) {
    switch (subwayLine) {
      case '1호선':
        return const Color(0xFF263C96);
      case '2호선':
        return const Color(0xFF00A84D);
      case '3호선':
        return const Color(0xFFEF7C1C);
      case '4호선':
        return const Color(0xFF00A4E3);
      case '5호선':
        return const Color(0xFF996CAC);
      case '6호선':
        return const Color(0xFFCD7C2F);
      case '7호선':
        return const Color(0xFF747F00);
      case '8호선':
        return const Color(0xFFE6186C);
      case '9호선':
        return const Color(0xFFBB8336);
      default:
        return Theme.of(context).primaryColor;
    }
  }

  String _getSubwayLineNumber(String? subwayLine) {
    if (subwayLine == null) return '?';

    final lineNumber = subwayLine.replaceAll('호선', '');
    if (lineNumber.length <= 2) {
      return lineNumber;
    }

    // 긴 이름의 경우 첫 글자들만 사용
    switch (subwayLine) {
      case '중앙선':
        return '중앙';
      case '경춘선':
        return '경춘';
      case '수인분당선':
        return '수분';
      case '신분당선':
        return '신분';
      case '경의중앙선':
        return '경의';
      case '공항철도':
        return '공항';
      case '우이신설선':
        return '우신';
      default:
        return lineNumber.substring(0, 2);
    }
  }

  /// 방향 정보 반환
  Map<String, String> _getDirectionInfo(String? updnLine) {
    if (updnLine == null) return {'text': '정보없음', 'description': '방향 정보가 없습니다'};

    switch (updnLine) {
      case '0':
      case '상행':
        return {'text': '상행선', 'description': '내선순환 또는 서울역/종로 방향'};
      case '1':
      case '하행':
        return {'text': '하행선', 'description': '외선순환 또는 강남/잠실 방향'};
      default:
        return {'text': updnLine, 'description': '기타 방향'};
    }
  }

  /// 방향별 색상 반환
  Color _getDirectionColor(String? updnLine) {
    switch (updnLine) {
      case '0':
      case '상행':
        return const Color(0xFF2196F3); // 파랑 (상행)
      case '1':
      case '하행':
        return const Color(0xFFFF5722); // 주황 (하행)
      default:
        return Colors.grey[600]!;
    }
  }

  /// 방향별 아이콘 반환
  IconData _getDirectionIcon(String? updnLine) {
    switch (updnLine) {
      case '0':
      case '상행':
        return Icons.keyboard_arrow_up;
      case '1':
      case '하행':
        return Icons.keyboard_arrow_down;
      default:
        return Icons.help_outline;
    }
  }

  Widget _buildTemporaryChatRoom() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 1,
              color: Colors.grey[300]!,
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async => await _navigateToChatRoom('temp_chat_room'),
            child: Padding(
              padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // 상단: 임시방 정보
                Row(
                  children: [
                    // 임시방 아이콘
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 2,
                          color: Colors.orange,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '임시',
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),

                    // 임시방 정보
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '임시 채팅방',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 19,
                              color: Color(0xFF1A1A1A),
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '위치에 상관없이 입장 가능한 테스트 채팅방',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                
                // 구분선
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
                
                const SizedBox(height: 16),

                // 하단: 접근 정보와 입장 버튼
                Row(
                  children: [
                    // 접근 정보
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 1,
                          color: Colors.orange,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.public,
                            size: 16,
                            color: Colors.orange[700],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '전체 접근',
                            style: TextStyle(
                              color: Colors.orange[700],
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // 입장 버튼
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 2,
                          color: Colors.orange,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '채팅 입장',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLocationPermissionDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.location_off, color: Colors.orange),
              SizedBox(width: 8),
              Text('위치 권한 필요'),
            ],
          ),
          content: const Text(
            '이 앱은 위치 서비스를 사용합니다.\n'
            '설정에서 위치 권한을 허용해주세요.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('나중에'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _locationService.openAppSettings();
              },
              child: const Text('설정 열기'),
            ),
          ],
        );
      },
    );
  }

  void _showForceRefreshDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.refresh, color: Colors.orange),
              SizedBox(width: 8),
              Text('강제 새로고침'),
            ],
          ),
          content: const Text(
            '모든 캐시를 무시하고 서버에서 최신 데이터를 가져옵니다.\n'
            '데이터 사용량이 늘어날 수 있습니다.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _loadNearbyTrains(forceRefresh: true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('강제 새로고침'),
            ),
          ],
        );
      },
    );
  }

  void _showDistanceAlert(String message, bool isWarning) {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: !isWarning, // 경고가 아닐 때만 바깥 터치로 닫기 가능
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                isWarning ? Icons.warning : Icons.info,
                color: isWarning ? Colors.orange : Colors.blue,
              ),
              const SizedBox(width: 8),
              Text(isWarning ? '거리 경고' : '알림'),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (!isWarning) {
                  // 자동 퇴장의 경우 로그인 화면으로 이동
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil('/login', (route) => false);
                }
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}