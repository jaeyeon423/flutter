import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  // 로그인 상태 저장 키
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userEmailKey = 'user_email';
  static const String _loginMethodKey = 'login_method';

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;
  
  /// 앱 시작 시 저장된 로그인 상태 확인
  Future<bool> checkSavedLoginState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
      final savedEmail = prefs.getString(_userEmailKey);
      
      if (isLoggedIn && savedEmail != null) {
        // Firebase Auth가 자동으로 세션을 복원했는지 확인
        if (_auth.currentUser != null) {
          debugPrint('[PERSISTENT_AUTH] ✅ 저장된 로그인 상태 복원 성공: $savedEmail');
          await _updateUserOnlineStatus(_auth.currentUser!.uid, true);
          return true;
        } else {
          // Firebase 세션이 만료된 경우 저장된 상태 제거
          debugPrint('[PERSISTENT_AUTH] ⚠️ Firebase 세션 만료, 저장된 상태 제거');
          await _clearSavedLoginState();
          return false;
        }
      }
      
      return false;
    } catch (e) {
      debugPrint('[PERSISTENT_AUTH] ❌ 저장된 로그인 상태 확인 실패: $e');
      return false;
    }
  }
  
  /// 로그인 상태를 로컬에 저장
  Future<void> _saveLoginState(String email, String method) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_userEmailKey, email);
      await prefs.setString(_loginMethodKey, method);
      debugPrint('[PERSISTENT_AUTH] ✅ 로그인 상태 저장: $email ($method)');
    } catch (e) {
      debugPrint('[PERSISTENT_AUTH] ❌ 로그인 상태 저장 실패: $e');
    }
  }
  
  /// 저장된 로그인 상태 제거
  Future<void> _clearSavedLoginState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_isLoggedInKey);
      await prefs.remove(_userEmailKey);
      await prefs.remove(_loginMethodKey);
      debugPrint('[PERSISTENT_AUTH] ✅ 저장된 로그인 상태 제거');
    } catch (e) {
      debugPrint('[PERSISTENT_AUTH] ❌ 로그인 상태 제거 실패: $e');
    }
  }

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
        await _saveLoginState(email, 'email_password');
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
        await _saveLoginState(email, 'email_password');
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
        await _saveLoginState(result.user!.email ?? '', 'google');
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
      await _clearSavedLoginState();
      debugPrint('[FIREBASE_AUTH] ✅ 로그아웃 성공');
    } catch (e) {
      debugPrint('[FIREBASE_AUTH] ❌ 로그아웃 실패: $e');
      throw Exception('로그아웃 중 오류가 발생했습니다: ${e.toString()}');
    }
  }

  /// 닉네임 변경
  Future<void> updateDisplayName(String newDisplayName) async {
    debugPrint('[FIREBASE_AUTH] 👤 닉네임 변경 시도: $newDisplayName');
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('로그인이 필요합니다');
      }

      // Firebase Auth 프로필 업데이트
      await user.updateDisplayName(newDisplayName);
      await user.reload(); // 사용자 정보 새로고침
      
      // Firestore 사용자 문서 업데이트
      await _firestore.collection('users').doc(user.uid).update({
        'displayName': newDisplayName,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      debugPrint('[FIREBASE_AUTH] ✅ 닉네임 변경 성공: $newDisplayName');
    } on FirebaseAuthException catch (e) {
      debugPrint('[FIREBASE_AUTH] ❌ 닉네임 변경 실패: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      debugPrint('[FIREBASE_AUTH] ❌ 닉네임 변경 실패: $e');
      throw Exception('닉네임 변경 중 오류가 발생했습니다: ${e.toString()}');
    }
  }

  /// 비밀번호 변경
  Future<void> updatePassword(String currentPassword, String newPassword) async {
    debugPrint('[FIREBASE_AUTH] 🔒 비밀번호 변경 시도');
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('로그인이 필요합니다');
      }

      if (user.email == null) {
        throw Exception('이메일 계정이 아닙니다');
      }

      // 현재 비밀번호로 재인증
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      
      await user.reauthenticateWithCredential(credential);
      debugPrint('[FIREBASE_AUTH] ✅ 재인증 성공');
      
      // 새 비밀번호로 변경
      await user.updatePassword(newPassword);
      debugPrint('[FIREBASE_AUTH] ✅ 비밀번호 변경 성공');
      
      // Firestore 업데이트 시간 기록
      await _firestore.collection('users').doc(user.uid).update({
        'passwordUpdatedAt': FieldValue.serverTimestamp(),
      });
      
    } on FirebaseAuthException catch (e) {
      debugPrint('[FIREBASE_AUTH] ❌ 비밀번호 변경 실패: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      debugPrint('[FIREBASE_AUTH] ❌ 비밀번호 변경 실패: $e');
      throw Exception('비밀번호 변경 중 오류가 발생했습니다: ${e.toString()}');
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
        return '비밀번호가 너무 약합니다. (최소 6자리 이상)';
      case 'invalid-email':
        return '유효하지 않은 이메일 형식입니다.';
      case 'too-many-requests':
        return '너무 많은 시도가 있었습니다. 잠시 후 다시 시도해주세요.';
      case 'requires-recent-login':
        return '보안을 위해 최근에 로그인이 필요합니다.';
      default:
        return '인증 중 오류가 발생했습니다: ${e.message}';
    }
  }
}
