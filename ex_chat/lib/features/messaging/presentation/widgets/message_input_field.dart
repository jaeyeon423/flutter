import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_chat/features/messaging/presentation/providers/messaging_providers.dart';
import 'package:ex_chat/features/auth/presentation/providers/auth_providers.dart';

class MessageInputField extends ConsumerWidget {
  final String roomId;

  const MessageInputField({
    super.key,
    required this.roomId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(messageInputControllerProvider);
    final userAsync = ref.watch(anonymousUserProvider);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: InputBorder.none,
              ),
              maxLines: null,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () async {
              if (controller.text.isNotEmpty && userAsync.value != null) {
                await ref.read(sendMessageProvider((
                  roomId: roomId,
                  content: controller.text,
                  senderId: userAsync.value!.uid,
                )).future);
                controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
