// lib/auth_providers.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_app/firebase_providers.dart'; // Import the firebase providers
import 'dart:io'; // Required for File type in AuthNotifier

// StreamProvider for auth state changes
final authStateChangesProvider = StreamProvider<User?>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return firebaseAuth.authStateChanges();
});


// For managing AuthScreen's specific UI state during auth operations
enum AuthStatus { initial, loading, success, error }

class AuthScreenState {
  final AuthStatus status;
  final String? errorMessage;
  // Potentially user data if needed directly after auth, though authStateChangesProvider handles navigation
  // final User? user;

  AuthScreenState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    // this.user,
  });

  AuthScreenState copyWith({
    AuthStatus? status,
    String? errorMessage,
    // User? user,
  }) {
    return AuthScreenState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      // user: user ?? this.user,
    );
  }
}


// AsyncNotifierProvider for authentication logic (sign-in, sign-up)
final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthScreenState>(() {
  return AuthNotifier();
});

class AuthNotifier extends AsyncNotifier<AuthScreenState> {
  @override
  Future<AuthScreenState> build() async {
    // The initial state of the notifier.
    // It's an AsyncNotifier, so it needs to return a Future.
    return AuthScreenState();
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = const AsyncLoading(); // Indicate loading state
    final firebaseAuth = ref.read(firebaseAuthProvider);
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // On success, authStateChangesProvider will trigger navigation.
      // We update our local state to reflect success, which can be used for UI feedback if needed.
      state = AsyncData(AuthScreenState(status: AuthStatus.success));
    } on FirebaseAuthException catch (e) {
      state = AsyncData(AuthScreenState(status: AuthStatus.error, errorMessage: e.message));
    } catch (e) {
      state = AsyncData(AuthScreenState(status: AuthStatus.error, errorMessage: 'An unknown error occurred.'));
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password, File? imageFile) async {
    state = const AsyncLoading(); // Indicate loading state
    final firebaseAuth = ref.read(firebaseAuthProvider);
    final firebaseStorage = ref.read(firebaseStorageProvider);

    if (imageFile == null) {
      state = AsyncData(AuthScreenState(status: AuthStatus.error, errorMessage: 'Please pick an image.'));
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
      // final imageUrl = await storageRef.getDownloadURL();
      // print('User image URL: $imageUrl'); // You might store this URL in Firestore later

      // On success, authStateChangesProvider will trigger navigation.
      state = AsyncData(AuthScreenState(status: AuthStatus.success));
    } on FirebaseAuthException catch (e) {
      state = AsyncData(AuthScreenState(status: AuthStatus.error, errorMessage: e.message));
    } catch (e) {
      state = AsyncData(AuthScreenState(status: AuthStatus.error, errorMessage: 'An unknown error occurred.'));
    }
  }
}
