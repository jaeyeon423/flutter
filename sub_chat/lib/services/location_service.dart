import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import 'subway_service.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  Timer? _locationTimer;
  Position? _currentPosition;
  bool _isServiceRunning = false;
  Function(Position)? _onLocationUpdate;
  
  // 지하철 관련 필드
  final SubwayService _subwayService = SubwayService();
  List<TrainPosition> _nearbyTrains = [];
  Function(List<TrainPosition>)? _onNearbyTrainsUpdate;
  
  // 채팅방 모니터링 관련
  String? _currentChatRoomTrainId;
  String? _currentChatRoomSubwayLine;
  int _distanceWarningCount = 0;
  Function(String message, bool isWarning)? _onDistanceAlert;

  /// 위치 서비스 초기화 및 시작
  Future<bool> initialize(
    Function(Position) onLocationUpdate, {
    Function(List<TrainPosition>)? onNearbyTrainsUpdate,
    Function(String message, bool isWarning)? onDistanceAlert,
  }) async {
    debugPrint('[LOCATION] 📍 위치 서비스 초기화 시작');
    _onLocationUpdate = onLocationUpdate;
    _onNearbyTrainsUpdate = onNearbyTrainsUpdate;
    _onDistanceAlert = onDistanceAlert;
    
    try {
      // 권한 확인 및 요청
      if (!await _checkAndRequestPermissions()) {
        return false;
      }
      
      // 위치 서비스 활성화 확인
      if (!await _checkLocationService()) {
        return false;
      }
      
      // 초기 위치 획득
      await _getCurrentLocation();
      
      // 주기적 위치 체크 시작 (15분마다)
      _startLocationTimer();
      
      _isServiceRunning = true;
      debugPrint('[LOCATION] ✅ 위치 서비스 초기화 성공');
      return true;
    } catch (e) {
      debugPrint('[LOCATION] ❌ 위치 서비스 초기화 실패: $e');
      return false;
    }
  }

  /// 위치 서비스 중지
  void stop() {
    _locationTimer?.cancel();
    _locationTimer = null;
    _isServiceRunning = false;
  }

  /// 현재 위치 상태 확인
  bool get isRunning => _isServiceRunning;
  Position? get currentPosition => _currentPosition;
  List<TrainPosition> get nearbyTrains => _nearbyTrains;

  /// 권한 확인 및 요청
  Future<bool> _checkAndRequestPermissions() async {
    // 위치 권한 상태 확인
    LocationPermission permission = await Geolocator.checkPermission();
    
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('[LOCATION] ⚠️ 위치 권한 거부됨');
        return false;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      debugPrint('[LOCATION] ❌ 위치 권한 영구 거부 - 설정에서 허용 필요');
      return false;
    }
    
    return true;
  }

  /// 위치 서비스 활성화 확인
  Future<bool> _checkLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('[LOCATION] ⚠️ 위치 서비스 비활성화 - 설정에서 활성화 필요');
      return false;
    }
    return true;
  }

  /// 현재 위치 획득
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10, // 10미터 이상 이동했을 때만 업데이트
        ),
      );
      
      _currentPosition = position;
      _onLocationUpdate?.call(position);
      
      // 근처 지하철 검색
      await _checkNearbyTrains(position);
      
      // 현재 채팅방 열차와의 거리 체크
      await _checkCurrentChatRoomDistance(position);
      
      debugPrint('[LOCATION] 📍 위치 업데이트: ${position.latitude}, ${position.longitude}');
    } catch (e) {
      debugPrint('[LOCATION] ❌ 위치 획득 실패: $e');
    }
  }

  /// 근처 지하철 검색
  Future<void> _checkNearbyTrains(Position position) async {
    try {
      final nearbyTrains = await _subwayService.getNearbyTrains(position);
      _nearbyTrains = nearbyTrains;
      _onNearbyTrainsUpdate?.call(nearbyTrains);
      
      if (nearbyTrains.isNotEmpty) {
        debugPrint('[LOCATION] 🚇 근처 지하철 ${nearbyTrains.length}개 발견');
        for (final train in nearbyTrains.take(3)) {
          debugPrint('[LOCATION] - ${train.displayName}: ${train.distanceFromUser?.toStringAsFixed(1)}m');
        }
      }
    } catch (e) {
      debugPrint('[LOCATION] ❌ 근처 지하철 검색 실패: $e');
    }
  }

  /// 현재 채팅방 열차와의 거리 체크
  Future<void> _checkCurrentChatRoomDistance(Position position) async {
    if (_currentChatRoomTrainId == null || _currentChatRoomSubwayLine == null) {
      return;
    }
    
    try {
      final isNear = await _subwayService.isUserNearTrain(
        position,
        _currentChatRoomTrainId!,
        _currentChatRoomSubwayLine!,
        radiusInMeters: 100.0,
      );
      
      if (!isNear) {
        _distanceWarningCount++;
        
        if (_distanceWarningCount == 1) {
          // 첫 번째 경고
          _onDistanceAlert?.call(
            '열차와 100m 이상 떨어졌습니다. 계속 떨어지면 채팅방에서 나가게 됩니다.',
            true,
          );
        } else if (_distanceWarningCount >= 2) {
          // 두 번째 경고 후 채팅방 나가기
          _onDistanceAlert?.call(
            '열차와 너무 멀어져 채팅방에서 나갑니다.',
            false,
          );
          _exitCurrentChatRoom();
        }
      } else {
        // 다시 가까워지면 경고 카운트 리셋
        _distanceWarningCount = 0;
      }
    } catch (e) {
      debugPrint('[LOCATION] ❌ 채팅방 열차 거리 체크 실패: $e');
    }
  }

  /// 주기적 위치 체크 타이머 시작 (15분마다)
  void _startLocationTimer() {
    _locationTimer = Timer.periodic(const Duration(minutes: 15), (timer) async {
      await _getCurrentLocation();
    });
  }

  /// 주소 변환 (간단한 형태)
  String getLocationString(Position position) {
    return '위도: ${position.latitude.toStringAsFixed(6)}\n'
           '경도: ${position.longitude.toStringAsFixed(6)}\n'
           '정확도: ${position.accuracy.toStringAsFixed(1)}m';
  }

  /// 두 위치 간의 거리 계산 (미터)
  double getDistanceBetween(Position pos1, Position pos2) {
    return Geolocator.distanceBetween(
      pos1.latitude,
      pos1.longitude,
      pos2.latitude,
      pos2.longitude,
    );
  }

  /// 권한 설정 페이지 열기
  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  /// 앱 설정 페이지 열기
  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  /// 채팅방 입장 시 호출 - 열차 정보 설정
  void enterChatRoom(String trainId, String subwayLine) {
    _currentChatRoomTrainId = trainId;
    _currentChatRoomSubwayLine = subwayLine;
    _distanceWarningCount = 0;
    debugPrint('[LOCATION] 🚇 채팅방 입장: $subwayLine $trainId호');
  }

  /// 채팅방 나가기
  void _exitCurrentChatRoom() {
    _currentChatRoomTrainId = null;
    _currentChatRoomSubwayLine = null;
    _distanceWarningCount = 0;
  }

  /// 수동으로 채팅방 나가기 (사용자가 직접 나갈 때)
  void exitChatRoom() {
    _exitCurrentChatRoom();
  }

  /// 현재 채팅방 정보 가져오기
  Map<String, String>? get currentChatRoomInfo {
    if (_currentChatRoomTrainId == null || _currentChatRoomSubwayLine == null) {
      return null;
    }
    return {
      'trainId': _currentChatRoomTrainId!,
      'subwayLine': _currentChatRoomSubwayLine!,
    };
  }

  /// 수동으로 근처 지하철 새로고침
  Future<void> refreshNearbyTrains() async {
    if (_currentPosition != null) {
      await _checkNearbyTrains(_currentPosition!);
    }
  }

  /// 강제 새로고침 (캐시 무시)
  Future<void> forceRefreshNearbyTrains() async {
    if (_currentPosition != null) {
      // 캐시를 무시하고 강제로 새로운 데이터 가져오기
      try {
        final nearbyTrains = await _subwayService.forceRefreshAllTrains();
        final filteredTrains = <TrainPosition>[];
        
        for (final train in nearbyTrains) {
          if (train.latitude != null && train.longitude != null) {
            final distance = Geolocator.distanceBetween(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
              train.latitude!,
              train.longitude!,
            );
            
            if (distance <= 100.0) {
              train.distanceFromUser = distance;
              filteredTrains.add(train);
            }
          }
        }
        
        filteredTrains.sort((a, b) => a.distanceFromUser!.compareTo(b.distanceFromUser!));
        _nearbyTrains = filteredTrains;
        _onNearbyTrainsUpdate?.call(filteredTrains);
        
        debugPrint('[LOCATION] 🔄 강제 새로고침: 근처 지하철 ${filteredTrains.length}개 발견');
      } catch (e) {
        debugPrint('[LOCATION] ❌ 강제 새로고침 실패: $e');
      }
    }
  }

  /// 캐시 상태 확인
  Map<String, dynamic> getCacheStatus() {
    return _subwayService.getCacheStatus();
  }
}