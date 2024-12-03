import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:future_provider/pages/users/user_list_page.dart';
import 'package:future_provider/providers/dio_provider.dart';
import 'package:future_provider/user.dart';

final userListProvider = FutureProvider.autoDispose<List<User>>((ref) async {
  ref.onDispose(() {
    print('[ usersProvider ]onDispose');
  });
  final response = await ref.watch(dioProvider).get('/users');
  final List userList = response.data;
  final users = [for (final user in userList) User.fromJson(user)];
  return users;
});
