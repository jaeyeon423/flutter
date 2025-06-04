import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_chat/services/firestore_service.dart';
import 'package:ex_chat/features/chat_room/domain/entities/chat_room.dart';

final chatRoomListProvider = StreamProvider<List<ChatRoom>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getChatRoomsStream();
});

final currentChatRoomProvider = StateProvider<ChatRoom?>((ref) => null);

final createChatRoomProvider =
    FutureProvider.family<void, String>((ref, roomName) async {
  final firestoreService = ref.watch(firestoreServiceProvider);
  await firestoreService.createChatRoom(roomName);
});
