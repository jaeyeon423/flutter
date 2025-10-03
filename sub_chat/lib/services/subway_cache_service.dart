import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'subway_service.dart';

/// Firestore를 이용한 지하철 데이터 캐싱 서비스
class SubwayCacheService {
  static final SubwayCacheService _instance = SubwayCacheService._internal();
  factory SubwayCacheService() => _instance;
  SubwayCacheService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionName = 'subway_cache';
  static const int _cacheValidMinutes = 5; // 5분간 유효

  /// 현재 UTC 시간을 기반으로 캐시 키를 생성합니다.
  String _getCacheKey() {
    return _getCacheKeyForTime(DateTime.now());
  }

  /// 주어진 [dateTime]을 UTC로 변환하여 캐시 키를 생성합니다.
  String _getCacheKeyForTime(DateTime dateTime) {
    final utcTime = dateTime.toUtc();
    return '${utcTime.year}-${utcTime.month.toString().padLeft(2, '0')}-${utcTime.day.toString().padLeft(2, '0')}_${utcTime.hour.toString().padLeft(2, '0')}:${utcTime.minute.toString().padLeft(2, '0')}';
  }

  /// Firestore에서 캐시된 데이터 조회
  Future<List<TrainPosition>?> getCachedTrainData() async {
    try {
      final cacheKey = _getCacheKey();
      debugPrint('[SUBWAY_CACHE] 🔍 캐시 조회 시작: $cacheKey');

      final doc = await _firestore
          .collection(_collectionName)
          .doc(cacheKey)
          .get();

      if (!doc.exists) {
        debugPrint('[SUBWAY_CACHE] ❌ 캐시 없음: $cacheKey');
        return null;
      }

      final data = doc.data()!;
      final timestamp = (data['timestamp'] as Timestamp).toDate();
      final now = DateTime.now();

      // 캐시 유효성 확인 (5분 이내)
      if (now.difference(timestamp).inMinutes > _cacheValidMinutes) {
        debugPrint('[SUBWAY_CACHE] ⏰ 캐시 만료: $cacheKey (${now.difference(timestamp).inMinutes}분 경과)');
        // 만료된 캐시 삭제
        _firestore.collection(_collectionName).doc(cacheKey).delete();
        return null;
      }

      // 캐시된 데이터를 TrainPosition 객체로 변환
      final trainsData = data['trains'] as List<dynamic>;
      final trains = trainsData
          .map((trainData) => TrainPosition.fromJson(trainData as Map<String, dynamic>))
          .toList();

      debugPrint('[SUBWAY_CACHE] ✅ 캐시 히트: $cacheKey (${trains.length}개 열차, ${timestamp.toString()})');
      return trains;
    } catch (e) {
      debugPrint('[SUBWAY_CACHE] ❌ 캐시 조회 실패: $e');
      return null;
    }
  }

  /// Firestore에 지하철 데이터 캐싱
  Future<void> cacheTrainData(List<TrainPosition> trains) async {
    try {
      final now = DateTime.now();
      final utcNow = now.toUtc();
      final cacheKey = _getCacheKeyForTime(now);

      // TrainPosition 객체를 JSON으로 변환
      final trainsData = trains.map((train) => train.toJson()).toList();

      final cacheData = {
        'timestamp': Timestamp.fromDate(now),
        'trains': trainsData,
        'count': trains.length,
        'year': utcNow.year,
        'month': utcNow.month,
        'day': utcNow.day,
        'hour': utcNow.hour,
        'minute': utcNow.minute,
      };

      await _firestore
          .collection(_collectionName)
          .doc(cacheKey)
          .set(cacheData);

      debugPrint('[SUBWAY_CACHE] 💾 캐시 저장: $cacheKey (${trains.length}개 열차)');
    } catch (e) {
      debugPrint('[SUBWAY_CACHE] ❌ 캐시 저장 실패: $e');
    }
  }

  /// 캐시된 데이터가 있는지 확인 (시간 범위 내)
  Future<bool> hasCachedData() async {
    try {
      final now = DateTime.now();
      final cacheKeys = <String>[];

      // 현재 시간과 이전 몇 분의 캐시도 확인
      for (int i = 0; i <= _cacheValidMinutes; i++) {
        final checkTime = now.subtract(Duration(minutes: i));
        cacheKeys.add(_getCacheKeyForTime(checkTime));
      }

      for (final cacheKey in cacheKeys) {
        final doc = await _firestore
            .collection(_collectionName)
            .doc(cacheKey)
            .get();

        if (doc.exists) {
          final data = doc.data()!;
          final timestamp = (data['timestamp'] as Timestamp).toDate();
          
          if (now.difference(timestamp).inMinutes <= _cacheValidMinutes) {
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      debugPrint('[SUBWAY_CACHE] ❌ 캐시 존재 확인 실패: $e');
      return false;
    }
  }

  /// 가장 최근의 유효한 캐시 데이터 조회
  Future<List<TrainPosition>?> getLatestCachedData() async {
    try {
      final now = DateTime.now();
      
      // 현재 시간부터 역순으로 확인
      for (int i = 0; i <= _cacheValidMinutes; i++) {
        final checkTime = now.subtract(Duration(minutes: i));
        final cacheKey = _getCacheKeyForTime(checkTime);
        
        final doc = await _firestore
            .collection(_collectionName)
            .doc(cacheKey)
            .get();

        if (doc.exists) {
          final data = doc.data()!;
          final timestamp = (data['timestamp'] as Timestamp).toDate();
          
          // 유효한 캐시인지 확인
          if (now.difference(timestamp).inMinutes <= _cacheValidMinutes) {
            final trainsData = data['trains'] as List<dynamic>;
            final trains = trainsData
                .map((trainData) => TrainPosition.fromJson(trainData as Map<String, dynamic>))
                .toList();
            
            debugPrint('[SUBWAY_CACHE] ✅ 최신 캐시 발견: $cacheKey (UTC), 로컬 시간: $timestamp (${trains.length}개 열차)');
            return trains;
          }
        }
      }
      
      debugPrint('[SUBWAY_CACHE] ❌ 유효한 캐시 없음');
      return null;
    } catch (e) {
      debugPrint('[SUBWAY_CACHE] ❌ 최신 캐시 조회 실패: $e');
      return null;
    }
  }

  /// 오래된 캐시 데이터 정리 (1시간 이상 된 데이터)
  Future<void> cleanupOldCache() async {
    try {
      final cutoffTime = DateTime.now().subtract(const Duration(hours: 1));
      
      // 컬렉션의 모든 문서 조회
      final snapshot = await _firestore
          .collection(_collectionName)
          .get();

      int deletedCount = 0;
      final batch = _firestore.batch();

      for (final doc in snapshot.docs) {
        final data = doc.data();
        final timestamp = (data['timestamp'] as Timestamp).toDate();

        if (timestamp.isBefore(cutoffTime)) {
          batch.delete(doc.reference);
          deletedCount++;
        }
      }

      if (deletedCount > 0) {
        await batch.commit();
        debugPrint('[SUBWAY_CACHE] 🧹 오래된 캐시 정리: $deletedCount개 삭제');
      }
    } catch (e) {
      debugPrint('[SUBWAY_CACHE] ❌ 캐시 정리 실패: $e');
    }
  }

  /// 모든 캐시 삭제
  Future<void> clearAllCache() async {
    try {
      final snapshot = await _firestore
          .collection(_collectionName)
          .get();

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      debugPrint('[SUBWAY_CACHE] 🗑️ 모든 캐시 삭제 완료: ${snapshot.docs.length}개');
    } catch (e) {
      debugPrint('[SUBWAY_CACHE] ❌ 전체 캐시 삭제 실패: $e');
    }
  }

  /// 캐시 통계 조회
  Future<Map<String, dynamic>> getCacheStats() async {
    try {
      final snapshot = await _firestore
          .collection(_collectionName)
          .get();

      final now = DateTime.now();
      int totalDocs = snapshot.docs.length;
      int validDocs = 0;
      int totalTrains = 0;

      for (final doc in snapshot.docs) {
        final data = doc.data();
        final timestamp = (data['timestamp'] as Timestamp).toDate();
        final trainCount = data['count'] as int? ?? 0;

        if (now.difference(timestamp).inMinutes <= _cacheValidMinutes) {
          validDocs++;
          totalTrains += trainCount;
        }
      }

      return {
        'totalDocuments': totalDocs,
        'validDocuments': validDocs,
        'totalTrains': totalTrains,
        'lastUpdate': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      debugPrint('[SUBWAY_CACHE] ❌ 캐시 통계 조회 실패: $e');
      return {
        'error': e.toString(),
        'totalDocuments': 0,
        'validDocuments': 0,
        'totalTrains': 0,
      };
    }
  }
}