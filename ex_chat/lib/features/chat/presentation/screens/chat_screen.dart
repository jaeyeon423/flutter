import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('익명 채팅')),
      body: const Center(
        child: Text('채팅 화면입니다.', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
