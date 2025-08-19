import 'package:flutter/foundation.dart';

/// 현재 사용자가 입장한 채팅방 상태를 메모리에서 관리하는 서비스
class CurrentRoomService {
  static CurrentRoomService? _instance;
  static CurrentRoomService get instance {
    _instance ??= CurrentRoomService._();
    return _instance!;
  }

  CurrentRoomService._() {
    debugPrint('[CURRENT_ROOM] 🏠 CurrentRoomService가 메모리 모드로 생성되었습니다.');
  }

  // 메모리 기반 저장소
  Map<String, dynamic>? _currentRoom;
  final List<Map<String, dynamic>> _roomHistory = [];

  /// 현재 채팅방 정보 저장 (메모리)
  void setCurrentRoom({
    required String roomId,
    required String roomName,
    String? trainId,
    String? subwayLine,
  }) {
    final roomData = {
      'roomId': roomId,
      'roomName': roomName,
      'trainId': trainId,
      'subwayLine': subwayLine,
      'enteredAt': DateTime.now().toIso8601String(),
    };
    _currentRoom = roomData;
    _addToHistory(roomData);
    debugPrint('[CURRENT_ROOM] 💾 현재 채팅방 저장 (메모리): $roomName ($roomId)');
  }

  /// 현재 채팅방 정보 조회 (메모리)
  Map<String, dynamic>? getCurrentRoom() {
    return _currentRoom;
  }

  /// 현재 채팅방에서 나가기 (메모리에서 정보 삭제)
  void exitCurrentRoom() {
    if (_currentRoom != null) {
      debugPrint('[CURRENT_ROOM] 🚪 현재 채팅방 정보 삭제 (메모리): ${_currentRoom!['roomName']}');
      _currentRoom = null;
    } else {
      debugPrint('[CURRENT_ROOM] 🚪 삭제할 현재 채팅방 정보가 없습니다.');
    }
  }

  /// 현재 사용자가 채팅방에 입장 중인지 확인
  bool isInChatRoom() {
    return _currentRoom != null;
  }

  /// 특정 채팅방에 입장 중인지 확인
  bool isInRoom(String roomId) {
    return _currentRoom?['roomId'] == roomId;
  }

  /// 현재 채팅방 정보를 포맷된 문자열로 반환
  String? getCurrentRoomTitle() {
    if (_currentRoom == null) return null;

    final roomName = _currentRoom!['roomName'] as String?;
    final subwayLine = _currentRoom!['subwayLine'] as String?;
    final trainId = _currentRoom!['trainId'] as String?;

    if (subwayLine != null && trainId != null) {
      return '$subwayLine $trainId호';
    }
    return roomName ?? '채팅방';
  }

  /// 메모리 방문 기록에 추가
  void _addToHistory(Map<String, dynamic> roomData) {
    // 동일한 방이 있으면 제거 (중복 방지)
    _roomHistory.removeWhere((item) => item['roomId'] == roomData['roomId']);
    
    // 새 기록을 맨 앞에 추가
    _roomHistory.insert(0, roomData);
    
    // 최대 10개까지만 보관
    if (_roomHistory.length > 10) {
      _roomHistory.removeLast();
    }
    debugPrint('[CURRENT_ROOM] 📝 방문 기록 업데이트 (메모리): ${_roomHistory.length}개');
  }

  /// 채팅방 방문 기록 조회 (메모리)
  List<Map<String, dynamic>> getRoomHistory() {
    return List.from(_roomHistory);
  }

  /// 채팅방 방문 기록 삭제 (메모리)
  void clearRoomHistory() {
    _roomHistory.clear();
    debugPrint('[CURRENT_ROOM] 🗑️ 방문 기록 삭제 완료 (메모리)');
  }

  /// 환승 시 확인 다이얼로그 필요 여부 확인
  bool shouldShowTransferConfirmation(String newRoomId) {
    if (_currentRoom == null) return false;
    
    final currentRoomId = _currentRoom!['roomId'] as String?;
    return currentRoomId != null && currentRoomId != newRoomId;
  }

  /// 디버그 정보 출력
  void debugCurrentState() {
    if (kDebugMode) {
      debugPrint('[CURRENT_ROOM] 🔍 현재 상태 (메모리):');
      debugPrint('  - 현재 방: ${_currentRoom?.toString() ?? "없음"}');
      debugPrint('  - 방문 기록: ${_roomHistory.length}개');
    }
  }
}
