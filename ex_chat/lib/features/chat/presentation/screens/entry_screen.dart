import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/chat');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: const Text('채팅방 입장', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
