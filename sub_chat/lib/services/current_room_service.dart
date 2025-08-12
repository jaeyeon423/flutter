import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 현재 사용자가 입장한 채팅방 상태를 관리하는 서비스
class CurrentRoomService {
  static const String _currentRoomKey = 'current_chat_room';
  static const String _roomHistoryKey = 'chat_room_history';

  static CurrentRoomService? _instance;
  static CurrentRoomService get instance {
    _instance ??= CurrentRoomService._();
    return _instance!;
  }

  CurrentRoomService._();

  SharedPreferences? _prefs;

  /// 서비스 초기화 (안전한 에러 처리)
  Future<bool> initialize() async {
    if (_prefs != null) return true;
    
    try {
      _prefs = await SharedPreferences.getInstance();
      debugPrint('[CURRENT_ROOM] 🏠 현재 채팅방 서비스 초기화 완료');
      return true;
    } catch (e) {
      debugPrint('[CURRENT_ROOM] ❌ SharedPreferences 초기화 실패: $e');
      debugPrint('[CURRENT_ROOM] 🔄 메모리 기반 모드로 전환');
      return false;
    }
  }

  // 메모리 기반 백업 저장소
  Map<String, dynamic>? _memoryCurrentRoom;
  List<Map<String, dynamic>> _memoryHistory = [];

  /// 현재 채팅방 정보 저장
  Future<void> setCurrentRoom({
    required String roomId,
    required String roomName,
    String? trainId,
    String? subwayLine,
  }) async {
    final isInitialized = await initialize();
    
    final roomData = {
      'roomId': roomId,
      'roomName': roomName,
      'trainId': trainId,
      'subwayLine': subwayLine,
      'enteredAt': DateTime.now().toIso8601String(),
    };

    if (isInitialized && _prefs != null) {
      try {
        await _prefs!.setString(_currentRoomKey, jsonEncode(roomData));
        await _addToHistory(roomData);
        debugPrint('[CURRENT_ROOM] 💾 현재 채팅방 저장 (로컬): $roomName ($roomId)');
      } catch (e) {
        debugPrint('[CURRENT_ROOM] ❌ 로컬 저장 실패: $e, 메모리 저장 사용');
        _memoryCurrentRoom = roomData;
        _addToMemoryHistory(roomData);
      }
    } else {
      _memoryCurrentRoom = roomData;
      _addToMemoryHistory(roomData);
      debugPrint('[CURRENT_ROOM] 💾 현재 채팅방 저장 (메모리): $roomName ($roomId)');
    }
  }

  /// 현재 채팅방 정보 조회
  Map<String, dynamic>? getCurrentRoom() {
    // 메모리 저장소 우선 확인
    if (_memoryCurrentRoom != null) {
      return _memoryCurrentRoom;
    }

    // SharedPreferences 확인
    if (_prefs == null) return null;

    try {
      final roomString = _prefs!.getString(_currentRoomKey);
      if (roomString == null) return null;

      return jsonDecode(roomString) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('[CURRENT_ROOM] ❌ 현재 채팅방 데이터 파싱 실패: $e');
      return null;
    }
  }

  /// 현재 채팅방에서 나가기 (저장된 정보 삭제)
  Future<void> exitCurrentRoom() async {
    // 메모리 저장소 삭제
    _memoryCurrentRoom = null;
    
    // SharedPreferences 삭제 (가능한 경우)
    final isInitialized = await initialize();
    if (isInitialized && _prefs != null) {
      try {
        await _prefs!.remove(_currentRoomKey);
        debugPrint('[CURRENT_ROOM] 🚪 현재 채팅방 정보 삭제 (로컬)');
      } catch (e) {
        debugPrint('[CURRENT_ROOM] ❌ 로컬 삭제 실패: $e');
      }
    }
    debugPrint('[CURRENT_ROOM] 🚪 현재 채팅방 정보 삭제 완료');
  }

  /// 현재 사용자가 채팅방에 입장 중인지 확인
  bool isInChatRoom() {
    return getCurrentRoom() != null;
  }

  /// 특정 채팅방에 입장 중인지 확인
  bool isInRoom(String roomId) {
    final currentRoom = getCurrentRoom();
    return currentRoom?['roomId'] == roomId;
  }

  /// 현재 채팅방 정보를 포맷된 문자열로 반환
  String? getCurrentRoomTitle() {
    final currentRoom = getCurrentRoom();
    if (currentRoom == null) return null;

    final roomName = currentRoom['roomName'] as String?;
    final subwayLine = currentRoom['subwayLine'] as String?;
    final trainId = currentRoom['trainId'] as String?;

    if (subwayLine != null && trainId != null) {
      return '$subwayLine $trainId호';
    }
    return roomName ?? '채팅방';
  }

  /// 채팅방 방문 기록에 추가
  Future<void> _addToHistory(Map<String, dynamic> roomData) async {
    try {
      final historyString = _prefs!.getString(_roomHistoryKey);
      List<Map<String, dynamic>> history = [];

      if (historyString != null) {
        try {
          final historyList = jsonDecode(historyString) as List;
          history = historyList.cast<Map<String, dynamic>>();
        } catch (e) {
          debugPrint('[CURRENT_ROOM] ❌ 기록 파싱 실패: $e');
        }
      }

      // 동일한 방이 있으면 제거 (중복 방지)
      history.removeWhere((item) => item['roomId'] == roomData['roomId']);
      
      // 새 기록을 맨 앞에 추가
      history.insert(0, roomData);
      
      // 최대 10개까지만 보관
      if (history.length > 10) {
        history = history.take(10).toList();
      }

      await _prefs!.setString(_roomHistoryKey, jsonEncode(history));
      debugPrint('[CURRENT_ROOM] 📝 방문 기록 업데이트 (로컬): ${history.length}개');
    } catch (e) {
      debugPrint('[CURRENT_ROOM] ❌ 로컬 기록 업데이트 실패: $e, 메모리 저장 사용');
      _addToMemoryHistory(roomData);
    }
  }

  /// 메모리 방문 기록에 추가
  void _addToMemoryHistory(Map<String, dynamic> roomData) {
    // 동일한 방이 있으면 제거
    _memoryHistory.removeWhere((item) => item['roomId'] == roomData['roomId']);
    
    // 새 기록을 맨 앞에 추가
    _memoryHistory.insert(0, roomData);
    
    // 최대 10개까지만 보관
    if (_memoryHistory.length > 10) {
      _memoryHistory = _memoryHistory.take(10).toList();
    }
  }

  /// 채팅방 방문 기록 조회
  List<Map<String, dynamic>> getRoomHistory() {
    // 메모리 저장소 우선 반환
    if (_memoryHistory.isNotEmpty) {
      return List.from(_memoryHistory);
    }

    // SharedPreferences 확인
    if (_prefs == null) return [];

    try {
      final historyString = _prefs!.getString(_roomHistoryKey);
      if (historyString == null) return [];

      final historyList = jsonDecode(historyString) as List;
      return historyList.cast<Map<String, dynamic>>();
    } catch (e) {
      debugPrint('[CURRENT_ROOM] ❌ 방문 기록 파싱 실패: $e');
      return [];
    }
  }

  /// 채팅방 방문 기록 삭제
  Future<void> clearRoomHistory() async {
    // 메모리 저장소 삭제
    _memoryHistory.clear();
    
    // SharedPreferences 삭제 (가능한 경우)
    final isInitialized = await initialize();
    if (isInitialized && _prefs != null) {
      try {
        await _prefs!.remove(_roomHistoryKey);
      } catch (e) {
        debugPrint('[CURRENT_ROOM] ❌ 로컬 기록 삭제 실패: $e');
      }
    }
    debugPrint('[CURRENT_ROOM] 🗑️ 방문 기록 삭제 완료');
  }

  /// 환승 시 확인 다이얼로그 필요 여부 확인
  bool shouldShowTransferConfirmation(String newRoomId) {
    final currentRoom = getCurrentRoom();
    if (currentRoom == null) return false;
    
    final currentRoomId = currentRoom['roomId'] as String?;
    return currentRoomId != null && currentRoomId != newRoomId;
  }

  /// 디버그 정보 출력
  void debugCurrentState() {
    if (kDebugMode) {
      final currentRoom = getCurrentRoom();
      final history = getRoomHistory();
      debugPrint('[CURRENT_ROOM] 🔍 현재 상태:');
      debugPrint('  - 현재 방: ${currentRoom?.toString() ?? "없음"}');
      debugPrint('  - 방문 기록: ${history.length}개');
    }
  }
}