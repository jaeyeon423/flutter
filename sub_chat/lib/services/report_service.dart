import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

enum ReportType {
  spam('스팸'),
  harassment('괴롭힘'),
  inappropriate('부적절한 내용'),
  hate('혐오 발언'),
  violence('폭력적 내용'),
  other('기타');

  const ReportType(this.displayName);
  final String displayName;
}

class ReportService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 메시지 신고
  Future<void> reportMessage({
    required String messageId,
    required String roomId,
    required String reportedUserId,
    required String reportedUserName,
    required String reporterUserId,
    required String reporterUserName,
    required String messageContent,
    required ReportType reportType,
    String? additionalReason,
  }) async {
    debugPrint('[REPORT_SERVICE] 🚨 메시지 신고 시작: $messageId');
    
    try {
      final reportRef = _firestore.collection('reports').doc();
      
      await reportRef.set({
        'id': reportRef.id,
        'type': 'message',
        'reportType': reportType.name,
        'reportTypeName': reportType.displayName,
        'messageId': messageId,
        'roomId': roomId,
        'messageContent': messageContent,
        'reportedUserId': reportedUserId,
        'reportedUserName': reportedUserName,
        'reporterUserId': reporterUserId,
        'reporterUserName': reporterUserName,
        'additionalReason': additionalReason,
        'status': 'pending', // pending, reviewed, resolved
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      debugPrint('[REPORT_SERVICE] ✅ 메시지 신고 완료: $messageId');
    } catch (e) {
      debugPrint('[REPORT_SERVICE] ❌ 메시지 신고 실패: $e');
      throw Exception('신고 처리 중 오류가 발생했습니다: ${e.toString()}');
    }
  }

  /// 사용자 신고
  Future<void> reportUser({
    required String reportedUserId,
    required String reportedUserName,
    required String reporterUserId,
    required String reporterUserName,
    required String roomId,
    required ReportType reportType,
    String? additionalReason,
  }) async {
    debugPrint('[REPORT_SERVICE] 🚨 사용자 신고 시작: $reportedUserId');
    
    try {
      final reportRef = _firestore.collection('reports').doc();
      
      await reportRef.set({
        'id': reportRef.id,
        'type': 'user',
        'reportType': reportType.name,
        'reportTypeName': reportType.displayName,
        'roomId': roomId,
        'reportedUserId': reportedUserId,
        'reportedUserName': reportedUserName,
        'reporterUserId': reporterUserId,
        'reporterUserName': reporterUserName,
        'additionalReason': additionalReason,
        'status': 'pending', // pending, reviewed, resolved
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      debugPrint('[REPORT_SERVICE] ✅ 사용자 신고 완료: $reportedUserId');
    } catch (e) {
      debugPrint('[REPORT_SERVICE] ❌ 사용자 신고 실패: $e');
      throw Exception('신고 처리 중 오류가 발생했습니다: ${e.toString()}');
    }
  }

  /// 사용자가 신고한 목록 조회
  Stream<QuerySnapshot> getUserReports(String userId) {
    debugPrint('[REPORT_SERVICE] 📋 사용자 신고 목록 조회: $userId');
    return _firestore
        .collection('reports')
        .where('reporterUserId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// 특정 사용자에 대한 신고 수 조회
  Future<int> getReportCount(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('reports')
          .where('reportedUserId', isEqualTo: userId)
          .where('status', isEqualTo: 'pending')
          .get();
      
      return snapshot.docs.length;
    } catch (e) {
      debugPrint('[REPORT_SERVICE] ❌ 신고 수 조회 실패: $e');
      return 0;
    }
  }

  /// 사용자가 이미 특정 메시지를 신고했는지 확인
  Future<bool> hasReportedMessage(String reporterUserId, String messageId) async {
    try {
      final snapshot = await _firestore
          .collection('reports')
          .where('reporterUserId', isEqualTo: reporterUserId)
          .where('messageId', isEqualTo: messageId)
          .where('type', isEqualTo: 'message')
          .limit(1)
          .get();
      
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      debugPrint('[REPORT_SERVICE] ❌ 신고 확인 실패: $e');
      return false;
    }
  }

  /// 사용자가 이미 특정 사용자를 신고했는지 확인
  Future<bool> hasReportedUser(String reporterUserId, String reportedUserId) async {
    try {
      final snapshot = await _firestore
          .collection('reports')
          .where('reporterUserId', isEqualTo: reporterUserId)
          .where('reportedUserId', isEqualTo: reportedUserId)
          .where('type', isEqualTo: 'user')
          .limit(1)
          .get();
      
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      debugPrint('[REPORT_SERVICE] ❌ 신고 확인 실패: $e');
      return false;
    }
  }
}