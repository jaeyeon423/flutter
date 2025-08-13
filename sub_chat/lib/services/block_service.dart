import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class BlockService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 사용자 차단
  Future<void> blockUser({
    required String blockerUserId,
    required String blockerUserName,
    required String blockedUserId,
    required String blockedUserName,
    String? reason,
  }) async {
    debugPrint('[BLOCK_SERVICE] 🚫 사용자 차단 시작: $blockedUserId');
    
    try {
      // 이미 차단되어 있는지 확인
      final existingBlock = await isUserBlocked(blockerUserId, blockedUserId);
      if (existingBlock) {
        debugPrint('[BLOCK_SERVICE] ⚠️ 이미 차단된 사용자: $blockedUserId');
        throw Exception('이미 차단된 사용자입니다.');
      }

      final blockRef = _firestore.collection('blocks').doc();
      
      await blockRef.set({
        'id': blockRef.id,
        'blockerUserId': blockerUserId,
        'blockerUserName': blockerUserName,
        'blockedUserId': blockedUserId,
        'blockedUserName': blockedUserName,
        'reason': reason,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      debugPrint('[BLOCK_SERVICE] ✅ 사용자 차단 완료: $blockedUserId');
    } catch (e) {
      debugPrint('[BLOCK_SERVICE] ❌ 사용자 차단 실패: $e');
      if (e.toString().contains('이미 차단된')) {
        rethrow;
      }
      throw Exception('차단 처리 중 오류가 발생했습니다: ${e.toString()}');
    }
  }

  /// 사용자 차단 해제
  Future<void> unblockUser({
    required String blockerUserId,
    required String blockedUserId,
  }) async {
    debugPrint('[BLOCK_SERVICE] 🔓 사용자 차단 해제 시작: $blockedUserId');
    
    try {
      final snapshot = await _firestore
          .collection('blocks')
          .where('blockerUserId', isEqualTo: blockerUserId)
          .where('blockedUserId', isEqualTo: blockedUserId)
          .get();

      if (snapshot.docs.isEmpty) {
        debugPrint('[BLOCK_SERVICE] ⚠️ 차단 기록이 없음: $blockedUserId');
        throw Exception('차단 기록을 찾을 수 없습니다.');
      }

      // 차단 기록 삭제
      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      debugPrint('[BLOCK_SERVICE] ✅ 사용자 차단 해제 완료: $blockedUserId');
    } catch (e) {
      debugPrint('[BLOCK_SERVICE] ❌ 사용자 차단 해제 실패: $e');
      if (e.toString().contains('차단 기록을')) {
        rethrow;
      }
      throw Exception('차단 해제 처리 중 오류가 발생했습니다: ${e.toString()}');
    }
  }

  /// 특정 사용자가 차단되어 있는지 확인
  Future<bool> isUserBlocked(String blockerUserId, String blockedUserId) async {
    try {
      final snapshot = await _firestore
          .collection('blocks')
          .where('blockerUserId', isEqualTo: blockerUserId)
          .where('blockedUserId', isEqualTo: blockedUserId)
          .limit(1)
          .get();
      
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      debugPrint('[BLOCK_SERVICE] ❌ 차단 상태 확인 실패: $e');
      return false;
    }
  }

  /// 사용자가 차단한 사용자 목록 조회
  Stream<QuerySnapshot> getBlockedUsers(String blockerUserId) {
    debugPrint('[BLOCK_SERVICE] 📋 차단된 사용자 목록 조회: $blockerUserId');
    return _firestore
        .collection('blocks')
        .where('blockerUserId', isEqualTo: blockerUserId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// 특정 사용자를 차단한 사용자 수 조회
  Future<int> getBlockedByCount(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('blocks')
          .where('blockedUserId', isEqualTo: userId)
          .get();
      
      return snapshot.docs.length;
    } catch (e) {
      debugPrint('[BLOCK_SERVICE] ❌ 차단당한 횟수 조회 실패: $e');
      return 0;
    }
  }

  /// 차단된 사용자들의 메시지 필터링을 위한 차단 목록 조회
  Future<List<String>> getBlockedUserIds(String blockerUserId) async {
    try {
      final snapshot = await _firestore
          .collection('blocks')
          .where('blockerUserId', isEqualTo: blockerUserId)
          .get();
      
      return snapshot.docs
          .map((doc) => doc.data()['blockedUserId'] as String)
          .toList();
    } catch (e) {
      debugPrint('[BLOCK_SERVICE] ❌ 차단된 사용자 ID 목록 조회 실패: $e');
      return [];
    }
  }

  /// 상호 차단 여부 확인 (A가 B를 차단하고, B가 A를 차단한 경우)
  Future<bool> isMutuallyBlocked(String userAId, String userBId) async {
    try {
      final aBlocksB = await isUserBlocked(userAId, userBId);
      final bBlocksA = await isUserBlocked(userBId, userAId);
      
      return aBlocksB || bBlocksA;
    } catch (e) {
      debugPrint('[BLOCK_SERVICE] ❌ 상호 차단 확인 실패: $e');
      return false;
    }
  }
}