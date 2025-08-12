import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<UserCredential?> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    debugPrint('[FIREBASE_AUTH] 🔑 로그인 시도: $email');
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        debugPrint('[FIREBASE_AUTH] ✅ 로그인 성공: ${result.user!.uid}');
        await _updateUserOnlineStatus(result.user!.uid, true);
      }

      return result;
    } on FirebaseAuthException catch (e) {
      debugPrint('[FIREBASE_AUTH] ❌ 로그인 실패: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    }
  }

  Future<UserCredential?> createUserWithEmailPassword(
    String email,
    String password,
    String displayName,
  ) async {
    debugPrint('[FIREBASE_AUTH] 🔐 회원가입 시도: $email');
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        debugPrint('[FIREBASE_AUTH] ✅ 회원가입 성공: ${result.user!.uid}');
        await result.user!.updateDisplayName(displayName);
        await _createUserDocument(result.user!, displayName);
        await _updateUserOnlineStatus(result.user!.uid, true);
      }

      return result;
    } on FirebaseAuthException catch (e) {
      debugPrint('[FIREBASE_AUTH] ❌ 회원가입 실패: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    debugPrint('[GOOGLE_AUTH] 🔑 Google 로그인 시도');
    try {
      // Google 로그인 트리거
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        debugPrint('[GOOGLE_AUTH] ❌ 사용자가 Google 로그인을 취소했습니다');
        throw Exception('Google 로그인이 취소되었습니다');
      }

      // Google 인증 정보 가져오기
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      // Firebase 인증 크리덴셜 생성
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase로 로그인
      UserCredential result = await _auth.signInWithCredential(credential);
      
      if (result.user != null) {
        debugPrint('[GOOGLE_AUTH] ✅ Google 로그인 성공: ${result.user!.uid}');
        
        // 사용자 문서 생성/업데이트
        await _createOrUpdateUserDocument(result.user!);
        await _updateUserOnlineStatus(result.user!.uid, true);
      }

      return result;
    } catch (e) {
      debugPrint('[GOOGLE_AUTH] ❌ Google 로그인 실패: $e');
      if (e is FirebaseAuthException) {
        throw _handleAuthException(e);
      } else {
        throw Exception('Google 로그인 중 오류가 발생했습니다: ${e.toString()}');
      }
    }
  }

  Future<void> signOut() async {
    debugPrint('[FIREBASE_AUTH] 🚪 로그아웃 시도');
    try {
      if (_auth.currentUser != null) {
        debugPrint('[FIREBASE_AUTH] 🔴 사용자 오프라인 상태로 변경: ${_auth.currentUser!.uid}');
        await _updateUserOnlineStatus(_auth.currentUser!.uid, false);
      }
      
      // Google 로그아웃도 함께 처리
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
        debugPrint('[GOOGLE_AUTH] ✅ Google 로그아웃 성공');
      }
      
      await _auth.signOut();
      debugPrint('[FIREBASE_AUTH] ✅ 로그아웃 성공');
    } catch (e) {
      debugPrint('[FIREBASE_AUTH] ❌ 로그아웃 실패: $e');
      throw Exception('로그아웃 중 오류가 발생했습니다: ${e.toString()}');
    }
  }

  Future<void> _createUserDocument(User user, String displayName) async {
    await _firestore.collection('users').doc(user.uid).set({
      'displayName': displayName,
      'email': user.email,
      'photoURL': user.photoURL,
      'createdAt': FieldValue.serverTimestamp(),
      'lastSeen': FieldValue.serverTimestamp(),
      'isOnline': true,
    });
  }

  Future<void> _createOrUpdateUserDocument(User user) async {
    final userRef = _firestore.collection('users').doc(user.uid);
    final userDoc = await userRef.get();
    
    if (userDoc.exists) {
      // 기존 사용자 - 프로필 정보 업데이트
      await userRef.update({
        'displayName': user.displayName ?? '사용자',
        'email': user.email,
        'photoURL': user.photoURL,
        'lastSeen': FieldValue.serverTimestamp(),
        'isOnline': true,
      });
      debugPrint('[FIRESTORE] ✅ 기존 사용자 정보 업데이트: ${user.uid}');
    } else {
      // 새 사용자 - 문서 생성
      await userRef.set({
        'displayName': user.displayName ?? '사용자',
        'email': user.email,
        'photoURL': user.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
        'lastSeen': FieldValue.serverTimestamp(),
        'isOnline': true,
      });
      debugPrint('[FIRESTORE] ✅ 새 사용자 문서 생성: ${user.uid}');
    }
  }

  Future<void> _updateUserOnlineStatus(String userId, bool isOnline) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'isOnline': isOnline,
        'lastSeen': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // 문서가 존재하지 않는 경우 기본 사용자 문서 생성
      if (e.toString().contains('not-found')) {
        try {
          final user = _auth.currentUser;
          if (user != null) {
            await _firestore.collection('users').doc(userId).set({
              'displayName': user.displayName ?? '사용자',
              'email': user.email,
              'photoURL': user.photoURL,
              'createdAt': FieldValue.serverTimestamp(),
              'lastSeen': FieldValue.serverTimestamp(),
              'isOnline': isOnline,
            });
            debugPrint('[FIRESTORE] ✅ 사용자 문서 새로 생성: $userId');
          }
        } catch (createError) {
          debugPrint('[FIRESTORE] ❌ 사용자 문서 생성 실패: $createError');
        }
      } else {
        debugPrint('[FIRESTORE] ❌ 온라인 상태 업데이트 실패: $e');
      }
    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return '등록되지 않은 이메일입니다.';
      case 'wrong-password':
        return '비밀번호가 잘못되었습니다.';
      case 'email-already-in-use':
        return '이미 사용 중인 이메일입니다.';
      case 'weak-password':
        return '비밀번호가 너무 약합니다.';
      case 'invalid-email':
        return '유효하지 않은 이메일 형식입니다.';
      case 'too-many-requests':
        return '너무 많은 시도가 있었습니다. 잠시 후 다시 시도해주세요.';
      default:
        return '인증 중 오류가 발생했습니다: ${e.message}';
    }
  }
}
