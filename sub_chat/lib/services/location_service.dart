import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  Timer? _locationTimer;
  Position? _currentPosition;
  bool _isServiceRunning = false;
  Function(Position)? _onLocationUpdate;

  /// 위치 서비스 초기화 및 시작
  Future<bool> initialize(Function(Position) onLocationUpdate) async {
    _onLocationUpdate = onLocationUpdate;
    
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
      
      // 주기적 위치 체크 시작 (1분마다)
      _startLocationTimer();
      
      _isServiceRunning = true;
      return true;
    } catch (e) {
      print('위치 서비스 초기화 실패: $e');
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

  /// 권한 확인 및 요청
  Future<bool> _checkAndRequestPermissions() async {
    // 위치 권한 상태 확인
    LocationPermission permission = await Geolocator.checkPermission();
    
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('위치 권한이 거부되었습니다.');
        return false;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      print('위치 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용해주세요.');
      return false;
    }
    
    return true;
  }

  /// 위치 서비스 활성화 확인
  Future<bool> _checkLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('위치 서비스가 비활성화되어 있습니다. 설정에서 위치 서비스를 활성화해주세요.');
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
      
      print('위치 업데이트: ${position.latitude}, ${position.longitude}');
    } catch (e) {
      print('위치 획득 실패: $e');
    }
  }

  /// 주기적 위치 체크 타이머 시작
  void _startLocationTimer() {
    _locationTimer = Timer.periodic(const Duration(minutes: 1), (timer) async {
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
}