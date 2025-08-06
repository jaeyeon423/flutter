import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';

class SubwayService {
  static final SubwayService _instance = SubwayService._internal();
  factory SubwayService() => _instance;
  SubwayService._internal();

  static const String _apiKey = '705646567a6a61653732666d436b6a';
  static const String _baseUrl = 'http://swopenAPI.seoul.go.kr/api/subway';
  static const String _service = 'realtimePosition';

  // 캐싱 관련 필드들
  final Map<String, List<TrainPosition>> _cachedTrainsByLine = {};
  final Map<String, DateTime> _cacheTimestamps = {};
  static const Duration _cacheValidityDuration = Duration(
    minutes: 2,
  ); // 2분간 캐시 유효

  // API 호출 제한 관련
  DateTime? _lastApiCall;
  static const Duration _minApiInterval = Duration(seconds: 30); // 최소 30초 간격

  // 서울 지하철 노선 리스트
  static const List<String> _subwayLines = [
    '1호선',
    '2호선',
    '3호선',
    '4호선',
    '5호선',
    '6호선',
    '7호선',
    '8호선',
    '9호선',
    '중앙선',
    '경춘선',
    '수인분당선',
    '신분당선',
    '경의중앙선',
    '공항철도',
    '우이신설선',
  ];

  /// 모든 노선의 실시간 열차 위치 정보 조회 (캐싱 적용)
  Future<List<TrainPosition>> getAllTrainPositions() async {
    // API 호출 제한 체크
    if (_lastApiCall != null &&
        DateTime.now().difference(_lastApiCall!) < _minApiInterval) {
      debugPrint(
        '[SUBWAY_API] ⏰ API 호출 간격 제한 (${_minApiInterval.inSeconds}초), 캐시된 데이터 반환',
      );
      return _getCachedTrains();
    }

    List<TrainPosition> allTrains = [];
    bool hasNewData = false;

    try {
      // 캐시 유효성 체크 및 선택적 업데이트
      final linesToUpdate = <String>[];
      for (final line in _subwayLines) {
        if (_shouldUpdateLine(line)) {
          linesToUpdate.add(line);
        } else {
          // 캐시된 데이터 사용
          final cachedTrains = _cachedTrainsByLine[line] ?? [];
          allTrains.addAll(cachedTrains);
        }
      }

      if (linesToUpdate.isNotEmpty) {
        debugPrint(
          '[SUBWAY_API] 🔄 업데이트 필요 노선: ${linesToUpdate.length}개 - $linesToUpdate',
        );

        // 업데이트가 필요한 노선만 API 호출
        final futures = linesToUpdate.map(
          (line) => _getTrainPositionsByLine(line),
        );
        final results = await Future.wait(futures);

        // 새로운 데이터를 캐시에 저장
        for (int i = 0; i < linesToUpdate.length; i++) {
          final line = linesToUpdate[i];
          final trains = results[i];
          _cachedTrainsByLine[line] = trains;
          _cacheTimestamps[line] = DateTime.now();
          allTrains.addAll(trains);
          hasNewData = true;
        }

        _lastApiCall = DateTime.now();
      }

      debugPrint(
        '[SUBWAY_API] ✅ 성공: 총 ${allTrains.length}개 열차 정보 조회 ${hasNewData ? '(새 데이터 포함)' : '(캐시 사용)'}',
      );
      return allTrains;
    } catch (e) {
      debugPrint('[SUBWAY_API] ❌ 전체 열차 조회 실패: $e');
      // 오류 시 캐시된 데이터라도 반환
      return _getCachedTrains();
    }
  }

  /// 캐싱된 모든 열차 데이터 반환
  List<TrainPosition> _getCachedTrains() {
    final allCachedTrains = <TrainPosition>[];
    for (final trains in _cachedTrainsByLine.values) {
      allCachedTrains.addAll(trains);
    }
    return allCachedTrains;
  }

  /// 특정 노선의 캐시 업데이트가 필요한지 확인
  bool _shouldUpdateLine(String line) {
    final cacheTime = _cacheTimestamps[line];
    if (cacheTime == null) return true; // 캐시된 데이터가 없음

    final timeSinceCache = DateTime.now().difference(cacheTime);
    return timeSinceCache > _cacheValidityDuration;
  }

  /// 특정 노선의 실시간 열차 위치 정보 조회
  Future<List<TrainPosition>> _getTrainPositionsByLine(
    String subwayLine,
  ) async {
    final url = '$_baseUrl/$_apiKey/json/$_service/1/100/$subwayLine';
    debugPrint('[SUBWAY_API] 🚇 $subwayLine API 호출 시작: $url');

    final stopwatch = Stopwatch()..start();
    try {
      final response = await http.get(Uri.parse(url));
      stopwatch.stop();
      debugPrint(
        '[SUBWAY_API] 📡 $subwayLine API 응답: ${response.statusCode} (${stopwatch.elapsedMilliseconds}ms)',
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // API 응답 구조 확인
        if (data['realtimePositionList'] != null) {
          final trainList = data['realtimePositionList'] as List;
          final trains = trainList
              .map((train) => TrainPosition.fromJson(train))
              .toList();

          debugPrint(
            '[SUBWAY_API] ✅ $subwayLine: ${trains.length}개 열차 데이터 조회 성공',
          );
          return trains;
        } else if (data['RESULT'] != null) {
          // 에러 응답 처리
          final result = data['RESULT'];
          debugPrint(
            '[SUBWAY_API] ⚠️ $subwayLine API 오류: ${result['MESSAGE']}',
          );
          return [];
        } else {
          debugPrint('[SUBWAY_API] ❓ $subwayLine: 예상하지 못한 응답 구조');
          final responseString = response.body;
          final endIndex = responseString.length < 500
              ? responseString.length
              : 500;
          debugPrint(
            '[SUBWAY_API] 📄 응답 데이터 ($endIndex자): ${responseString.substring(0, endIndex)}',
          );
          return [];
        }
      } else {
        debugPrint(
          '[SUBWAY_API] ❌ $subwayLine API 요청 실패: HTTP ${response.statusCode}',
        );
        final responseString = response.body;
        final endIndex = responseString.length < 500
            ? responseString.length
            : 500;
        debugPrint(
          '[SUBWAY_API] 📄 에러 응답 내용: ${responseString.substring(0, endIndex)}',
        );
        return [];
      }
    } catch (e) {
      stopwatch.stop();
      debugPrint(
        '[SUBWAY_API] ☠️ $subwayLine 예외 발생 (${stopwatch.elapsedMilliseconds}ms): $e',
      );
      return [];
    }
  }

  /// 사용자 위치 기준 근처 열차 찾기 (100m 이내)
  Future<List<TrainPosition>> getNearbyTrains(
    Position userPosition, {
    double radiusInMeters = 1500.0,
  }) async {
    final allTrains = await getAllTrainPositions();
    final nearbyTrains = <TrainPosition>[];

    for (final train in allTrains) {
      // 열차 위치가 유효한 경우에만 거리 계산
      if (train.latitude != null && train.longitude != null) {
        final distance = Geolocator.distanceBetween(
          userPosition.latitude,
          userPosition.longitude,
          train.latitude!,
          train.longitude!,
        );

        if (distance <= radiusInMeters) {
          train.distanceFromUser = distance;
          nearbyTrains.add(train);
        }
      }
    }

    // 거리순으로 정렬
    nearbyTrains.sort(
      (a, b) => a.distanceFromUser!.compareTo(b.distanceFromUser!),
    );

    debugPrint(
      '[SUBWAY_API] 📍 사용자 주변 ${radiusInMeters}m 이내 열차 ${nearbyTrains.length}개 발견',
    );
    return nearbyTrains;
  }

  /// 특정 열차의 현재 위치 조회 (캐시 우선 사용)
  Future<TrainPosition?> getTrainById(String trainNo, String subwayLine) async {
    try {
      // 먼저 캐시에서 찾기
      final cachedTrains = _cachedTrainsByLine[subwayLine];
      if (cachedTrains != null && !_shouldUpdateLine(subwayLine)) {
        for (final train in cachedTrains) {
          if (train.trainNo == trainNo) {
            return train;
          }
        }
      }

      // 캐시에 없거나 오래된 경우 API 호출
      final trains = await _getTrainPositionsByLine(subwayLine);
      _cachedTrainsByLine[subwayLine] = trains;
      _cacheTimestamps[subwayLine] = DateTime.now();

      for (final train in trains) {
        if (train.trainNo == trainNo) {
          return train;
        }
      }
      return null;
    } catch (e) {
      debugPrint('[SUBWAY_API] ❌ 열차 $trainNo ($subwayLine) 위치 조회 실패: $e');
      return null;
    }
  }

  /// 사용자가 특정 열차와 근처에 있는지 확인
  Future<bool> isUserNearTrain(
    Position userPosition,
    String trainNo,
    String subwayLine, {
    double radiusInMeters = 100.0,
  }) async {
    final train = await getTrainById(trainNo, subwayLine);

    if (train == null || train.latitude == null || train.longitude == null) {
      return false;
    }

    final distance = Geolocator.distanceBetween(
      userPosition.latitude,
      userPosition.longitude,
      train.latitude!,
      train.longitude!,
    );

    return distance <= radiusInMeters;
  }

  /// 캐시 상태 정보 반환 (디버깅/모니터링용)
  Map<String, dynamic> getCacheStatus() {
    final now = DateTime.now();
    final cacheInfo = <String, dynamic>{};

    for (final line in _subwayLines) {
      final cacheTime = _cacheTimestamps[line];
      final trainCount = _cachedTrainsByLine[line]?.length ?? 0;

      if (cacheTime != null) {
        final age = now.difference(cacheTime);
        cacheInfo[line] = {
          'trainCount': trainCount,
          'ageMinutes': age.inMinutes,
          'isValid': age <= _cacheValidityDuration,
        };
      } else {
        cacheInfo[line] = {'status': 'no_cache'};
      }
    }

    return {
      'lastApiCall': _lastApiCall?.toIso8601String(),
      'cacheInfo': cacheInfo,
    };
  }

  /// 특정 노선의 캐시 클리어
  void clearLineCache(String line) {
    _cachedTrainsByLine.remove(line);
    _cacheTimestamps.remove(line);
    // $line 캐시 클리어됨
  }

  /// 모든 캐시 클리어
  void clearAllCache() {
    _cachedTrainsByLine.clear();
    _cacheTimestamps.clear();
    _lastApiCall = null;
    // 모든 지하철 캐시 클리어됨
  }

  /// 수동 새로고침 (캐시 무시하고 강제 업데이트)
  Future<List<TrainPosition>> forceRefreshAllTrains() async {
    // 강제 새로고침: 모든 캐시 무시
    clearAllCache();
    return await getAllTrainPositions();
  }

  /// 특정 노선만 강제 새로고침
  Future<List<TrainPosition>> forceRefreshLine(String line) async {
    // $line 강제 새로고침
    clearLineCache(line);
    return await _getTrainPositionsByLine(line);
  }
}

/// 열차 위치 정보 모델
class TrainPosition {
  final String? subwayId; // 지하철호선ID
  final String? subwayNm; // 지하철호선명
  final String? statnId; // 지하철역ID
  final String? statnNm; // 지하철역명
  final String? trainNo; // 열차번호
  final String? lastRecptnDt; // 최종수신시간
  final String? recptnDt; // 수신시간
  final String? updnLine; // 상하행선구분
  final String? statnTid; // 역순번
  final String? statnTnm; // 종착지방면
  final String? trainSttus; // 열차상태
  final String? directAt; // 급행여부
  final String? lstcarAt; // 막차여부
  final double? latitude; // 위도 (API에서 제공되지 않을 수 있음)
  final double? longitude; // 경도 (API에서 제공되지 않을 수 있음)
  double? distanceFromUser; // 사용자로부터의 거리 (계산값)

  TrainPosition({
    this.subwayId,
    this.subwayNm,
    this.statnId,
    this.statnNm,
    this.trainNo,
    this.lastRecptnDt,
    this.recptnDt,
    this.updnLine,
    this.statnTid,
    this.statnTnm,
    this.trainSttus,
    this.directAt,
    this.lstcarAt,
    this.latitude,
    this.longitude,
    this.distanceFromUser,
  });

  factory TrainPosition.fromJson(Map<String, dynamic> json) {
    return TrainPosition(
      subwayId: json['subwayId']?.toString(),
      subwayNm: json['subwayNm']?.toString(),
      statnId: json['statnId']?.toString(),
      statnNm: json['statnNm']?.toString(),
      trainNo: json['trainNo']?.toString(),
      lastRecptnDt: json['lastRecptnDt']?.toString(),
      recptnDt: json['recptnDt']?.toString(),
      updnLine: json['updnLine']?.toString(),
      statnTid: json['statnTid']?.toString(),
      statnTnm: json['statnTnm']?.toString(),
      trainSttus: json['trainSttus']?.toString(),
      directAt: json['directAt']?.toString(),
      lstcarAt: json['lstcarAt']?.toString(),
      // 위도/경도는 API에서 제공되지 않을 수 있으므로 역 정보를 기반으로 추정해야 함
      latitude: _getStationLatitude(json['statnNm']?.toString()),
      longitude: _getStationLongitude(json['statnNm']?.toString()),
    );
  }

  /// 채팅방 ID 생성 (열차번호_노선명 형식)
  String get chatRoomId => '${trainNo}_$subwayNm';

  /// 열차 표시명 생성
  String get displayName =>
      '$subwayNm $trainNo호 (${_getDirectionText(updnLine)})';

  /// 현재 위치 설명
  String get currentLocationDescription => '$statnNm 방향 ($statnTnm 행)';

  /// 운행 방향 텍스트 변환
  String _getDirectionText(String? direction) {
    if (direction == null) return '정보없음';

    switch (direction) {
      case '0':
        return '상행선';
      case '1':
        return '하행선';
      case '상행':
        return '상행선';
      case '하행':
        return '하행선';
      default:
        return direction;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'subwayId': subwayId,
      'subwayNm': subwayNm,
      'statnId': statnId,
      'statnNm': statnNm,
      'trainNo': trainNo,
      'lastRecptnDt': lastRecptnDt,
      'recptnDt': recptnDt,
      'updnLine': updnLine,
      'statnTid': statnTid,
      'statnTnm': statnTnm,
      'trainSttus': trainSttus,
      'directAt': directAt,
      'lstcarAt': lstcarAt,
      'latitude': latitude,
      'longitude': longitude,
      'distanceFromUser': distanceFromUser,
    };
  }

  @override
  String toString() {
    return 'TrainPosition(trainNo: $trainNo, subwayNm: $subwayNm, statnNm: $statnNm, distance: ${distanceFromUser?.toStringAsFixed(1)}m)';
  }
}

// 주요 지하철역의 대략적인 위치 정보 (실제 운영시에는 정확한 좌표 DB 필요)
double? _getStationLatitude(String? stationName) {
  if (stationName == null) return null;

  final stationCoords = _getStationCoordinates();
  return stationCoords[stationName]?['lat'];
}

double? _getStationLongitude(String? stationName) {
  if (stationName == null) return null;

  final stationCoords = _getStationCoordinates();
  return stationCoords[stationName]?['lng'];
}

// 주요 지하철역 좌표 정보 (샘플 데이터)
Map<String, Map<String, double>> _getStationCoordinates() {
  return {
    '서울역': {'lat': 37.5546, 'lng': 126.9707},
    '강남역': {'lat': 37.4979, 'lng': 127.0276},
    '홍대입구': {'lat': 37.5564, 'lng': 126.9226},
    '신촌': {'lat': 37.5556, 'lng': 126.9364},
    '이대': {'lat': 37.5563, 'lng': 126.9463},
    '명동': {'lat': 37.5636, 'lng': 126.9834},
    '동대문': {'lat': 37.5713, 'lng': 127.0095},
    '잠실': {'lat': 37.5133, 'lng': 127.1000},
    '건대입구': {'lat': 37.5405, 'lng': 127.0699},
    '왕십리': {'lat': 37.5614, 'lng': 127.0374},
    '사당': {'lat': 37.4766, 'lng': 126.9814},
    '교대': {'lat': 37.4934, 'lng': 127.0144},
    '고속터미널': {'lat': 37.5050, 'lng': 127.0046},
    '신림': {'lat': 37.4842, 'lng': 126.9297},
    '구로': {'lat': 37.5033, 'lng': 126.8811},
    '영등포': {'lat': 37.5185, 'lng': 126.9066},
    // 더 많은 역 정보는 실제 운영시 추가 필요
  };
}
