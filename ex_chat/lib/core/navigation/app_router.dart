import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/chat/presentation/screens/entry_screen.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const EntryScreen()),
      GoRoute(path: '/chat', builder: (context, state) => const ChatScreen()),
    ],
  );
});
