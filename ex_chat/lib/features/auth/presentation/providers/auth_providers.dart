import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_chat/services/auth_service.dart';
import 'package:ex_chat/features/auth/domain/entities/anonymous_user.dart';

final anonymousUserProvider =
    StateNotifierProvider<AnonymousUserNotifier, AsyncValue<AnonymousUser?>>(
        (ref) {
  return AnonymousUserNotifier(ref.watch(authServiceProvider));
});

class AnonymousUserNotifier extends StateNotifier<AsyncValue<AnonymousUser?>> {
  final AuthService _authService;

  AnonymousUserNotifier(this._authService) : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    _authService.authStateChanges().listen((user) {
      if (user != null) {
        state = AsyncValue.data(AnonymousUser(uid: user.uid));
      } else {
        state = const AsyncValue.data(null);
      }
    });
  }

  Future<void> signInAnonymously() async {
    state = const AsyncValue.loading();
    try {
      final userCredential = await _authService.signInAnonymously();
      if (userCredential?.user != null) {
        state = AsyncValue.data(AnonymousUser(uid: userCredential!.user!.uid));
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
