import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<UserCredential?> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        await _updateUserOnlineStatus(result.user!.uid, true);
      }

      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<UserCredential?> createUserWithEmailPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        await result.user!.updateDisplayName(displayName);
        await _createUserDocument(result.user!, displayName);
        await _updateUserOnlineStatus(result.user!.uid, true);
      }

      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<void> signOut() async {
    try {
      if (_auth.currentUser != null) {
        await _updateUserOnlineStatus(_auth.currentUser!.uid, false);
      }
      await _auth.signOut();
    } catch (e) {
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
            print('사용자 문서가 없어서 새로 생성했습니다: $userId');
          }
        } catch (createError) {
          print('사용자 문서 생성 실패: $createError');
        }
      } else {
        print('온라인 상태 업데이트 실패: $e');
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
