import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/firebase_providers.dart';
import 'package:chat_app/auth_providers.dart';

// Provider for user profile data
final userProfileProvider = FutureProvider.family<Map<String, dynamic>?, String>((ref, uid) async {
  try {
    final firestore = ref.read(firebaseFirestoreProvider);
    final doc = await firestore.collection('users').doc(uid).get();
    return doc.data();
  } catch (e) {
    return null;
  }
});

class ProfileVerificationScreen extends ConsumerWidget {
  const ProfileVerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Double-check authentication state using both providers
    final authStateAsync = ref.watch(authStateChangesProvider);
    final currentUser = ref.watch(currentUserProvider);
    
    return authStateAsync.when(
      data: (streamUser) {
        // Verify both stream user and current user are consistent
        if (streamUser == null || currentUser == null || streamUser.uid != currentUser.uid) {
          // Authentication inconsistency detected, redirect to auth
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/auth');
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        return _buildVerificationScreen(context, ref, streamUser);
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) {
        // Auth error, redirect to auth screen
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed('/auth');
        });
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildVerificationScreen(BuildContext context, WidgetRef ref, User user) {
    final firebaseAuth = ref.read(firebaseAuthProvider);
    final userProfileAsync = ref.watch(userProfileProvider(user.uid));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo or Title
              Icon(
                Icons.verified_user,
                size: 80,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              const SizedBox(height: 24),
              Text(
                '로그인 확인',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              
              // User info card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: userProfileAsync.when(
                  data: (profile) => _buildUserInfo(context, user, profile),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stack) => _buildUserInfo(context, user, null),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Continue button
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const ChatScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    '채팅 시작하기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Logout button
              TextButton(
                onPressed: () async {
                  await firebaseAuth.signOut();
                },
                child: Text(
                  '다른 계정으로 로그인',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.8),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, User user, Map<String, dynamic>? profile) {
    return Column(
      children: [
        // Profile image
        CircleAvatar(
          radius: 40,
          backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          backgroundImage: profile?['image_url'] != null 
              ? NetworkImage(profile!['image_url']) 
              : null,
          child: profile?['image_url'] == null 
              ? Icon(
                  Icons.person,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                )
              : null,
        ),
        const SizedBox(height: 16),
        
        // User name
        Text(
          profile?['username'] ?? user.email?.split('@')[0] ?? '사용자',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        
        // Email
        Text(
          user.email ?? '이메일 없음',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 8),
        
        // User ID (for debugging/verification)
        Text(
          'ID: ${user.uid.substring(0, 8)}...',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 16),
        
        // Login status
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                size: 16,
                color: Colors.green[700],
              ),
              const SizedBox(width: 4),
              Text(
                '로그인 성공',
                style: TextStyle(
                  color: Colors.green[700],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}