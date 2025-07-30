import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_app/firebase_providers.dart';
import 'dart:io';

final authStateChangesProvider = StreamProvider<User?>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return firebaseAuth.authStateChanges();
});

final currentUserProvider = Provider<User?>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return firebaseAuth.currentUser;
});

enum AuthStatus { initial, loading, success, error }

class AuthScreenState {
  final AuthStatus status;
  final String? errorMessage;

  AuthScreenState({this.status = AuthStatus.initial, this.errorMessage});

  AuthScreenState copyWith({AuthStatus? status, String? errorMessage}) {
    return AuthScreenState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, AuthScreenState>(() {
      return AuthNotifier();
    });

class AuthNotifier extends AsyncNotifier<AuthScreenState> {
  @override
  Future<AuthScreenState> build() async {
    return AuthScreenState();
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = const AsyncLoading();
    final firebaseAuth = ref.read(firebaseAuthProvider);
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = AsyncData(AuthScreenState(status: AuthStatus.success));
    } on FirebaseAuthException catch (e) {
      state = AsyncData(
        AuthScreenState(status: AuthStatus.error, errorMessage: e.message),
      );
    } catch (e) {
      state = AsyncData(
        AuthScreenState(
          status: AuthStatus.error,
          errorMessage: 'An unknown error occurred.',
        ),
      );
    }
  }

  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
    File? imageFile,
  ) async {
    state = const AsyncLoading();
    final firebaseAuth = ref.read(firebaseAuthProvider);
    final firebaseStorage = ref.read(firebaseStorageProvider);
    final firebaseFirestore = ref.read(firebaseFirestoreProvider);

    if (imageFile == null) {
      state = AsyncData(
        AuthScreenState(
          status: AuthStatus.error,
          errorMessage: 'Please pick an image.',
        ),
      );
      return;
    }

    try {
      final userCredentials = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final storageRef = firebaseStorage
          .ref()
          .child('user_images')
          .child('${userCredentials.user!.uid}.jpg');

      await storageRef.putFile(imageFile);
      final imageUrl = await storageRef.getDownloadURL();

      await firebaseFirestore
          .collection('users')
          .doc(userCredentials.user!.uid)
          .set({
            'username': email.split('@')[0],
            'email': email,
            'image_url': imageUrl,
            'created_at': DateTime.now(),
          });

      state = AsyncData(AuthScreenState(status: AuthStatus.success));
    } on FirebaseAuthException catch (e) {
      state = AsyncData(
        AuthScreenState(status: AuthStatus.error, errorMessage: e.message),
      );
    } catch (e) {
      state = AsyncData(
        AuthScreenState(
          status: AuthStatus.error,
          errorMessage: 'An unknown error occurred.',
        ),
      );
    }
  }
}
