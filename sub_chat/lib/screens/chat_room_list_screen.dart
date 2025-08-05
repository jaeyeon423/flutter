import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/location_service.dart';
import '../services/subway_service.dart';
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

  List<TrainPosition> _nearbyTrains = [];
  bool _isLoadingTrains = false;
  @override
  void initState() {
    super.initState();
    _initializeLocationService();
  }

  @override
  void dispose() {
    _locationService.stop();
    super.dispose();
  }

  Future<void> _initializeLocationService() async {
    try {
      final success = await _locationService.initialize(
        (position) {
          if (mounted) {
            // 위치 업데이트 시 특별한 처리 없음
          }
        },
        onNearbyTrainsUpdate: (trains) {
          if (mounted) {
            setState(() {
              _nearbyTrains = trains;
            });
          }
        },
        onDistanceAlert: (message, isWarning) {
          if (mounted) {
            _showDistanceAlert(message, isWarning);
          }
        },
      );
      
      if (success) {
        // 위치 서비스 초기화 성공
        _initializeNearbyTrainsListener();
        _loadNearbyTrains();
      } else {
        // 위치 서비스 초기화 실패
        _showLocationPermissionDialog();
      }
    } catch (e) {
      // 위치 서비스 초기화 오류
    }
  }

  void _initializeNearbyTrainsListener() {
    // 근처 지하철 업데이트 리스너 등록
    _nearbyTrains = _locationService.nearbyTrains;
  }

  Future<void> _loadNearbyTrains({bool forceRefresh = false}) async {
    if (_isLoadingTrains) return;

    setState(() {
      _isLoadingTrains = true;
    });

    try {
      if (forceRefresh) {
        // 강제 새로고침 (캐시 무시)
        await _locationService.forceRefreshNearbyTrains();
      } else {
        // 일반 새로고침 (캐시 활용)
        await _locationService.refreshNearbyTrains();
      }
      
      setState(() {
        _nearbyTrains = _locationService.nearbyTrains;
      });
    } catch (e) {
      // 근처 지하철 로드 실패
    } finally {
      setState(() {
        _isLoadingTrains = false;
      });
    }
  }


  Future<void> _handleLogout() async {
    try {
      await _authService.signOut();
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

  void _navigateToChatRoom(String roomId, {TrainPosition? train}) {
    // 지하철 채팅방의 경우 위치 서비스에 열차 정보 등록
    if (train != null) {
      _locationService.enterChatRoom(train.trainNo!, train.subwayNm!);
    }

    // pushReplacement를 사용하여 뒤로 가기로 채팅방 리스트로 돌아갈 수 없게 함
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ChatRoomScreen(roomId: roomId)),
    );
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
        title: const Text('채팅'),
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
        onRefresh: () => _loadNearbyTrains(forceRefresh: true),
        child: ListView(
          children: [
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
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () => _loadNearbyTrains(forceRefresh: true),
                      iconSize: 20,
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
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
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
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
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

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: lineColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _navigateToChatRoom(train.chatRoomId, train: train),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // 상단: 노선 정보와 LIVE 배지
                  Row(
                    children: [
                      // 노선 아이콘
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: lineColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: lineColor.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            _getSubwayLineNumber(train.subwayNm),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      
                      // 열차 정보
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              train.displayName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              train.currentLocationDescription,
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
                      
                      // LIVE 배지
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'LIVE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // 하단: 거리 정보와 입장 버튼
                  Row(
                    children: [
                      // 거리 정보
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.green[200]!,
                            width: 1,
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
                          color: lineColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '채팅 입장',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: Colors.white,
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
      );
    }).toList();
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

  Widget _buildTemporaryChatRoom() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Card(
        elevation: 2,
        color: Colors.orange[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.orange.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _navigateToChatRoom('temp_chat_room'),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // 상단: 임시방 정보와 TEST 배지
                Row(
                  children: [
                    // 임시방 아이콘
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.orange[400],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          '임시',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // 임시방 정보
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '임시 채팅방',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87,
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
                    
                    // TEST 배지
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange[400],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'TEST',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
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
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.orange[200]!,
                          width: 1,
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
                        color: Colors.orange[400],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '채팅 입장',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: Colors.white,
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
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login',
                    (route) => false,
                  );
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
