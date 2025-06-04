import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_chat/services/firestore_service.dart';
import 'package:ex_chat/features/messaging/domain/entities/message.dart';

final messageStreamProvider =
    StreamProvider.family<List<Message>, String>((ref, roomId) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getMessagesStream(roomId);
});

final messageInputControllerProvider =
    StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final sendMessageProvider = FutureProvider.family<void,
    ({String roomId, String content, String senderId})>((ref, params) async {
  final firestoreService = ref.watch(firestoreServiceProvider);
  final message = Message(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    roomId: params.roomId,
    senderId: params.senderId,
    content: params.content,
    timestamp: DateTime.now(),
  );
  await firestoreService.sendMessage(params.roomId, message);
});
