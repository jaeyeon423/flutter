import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:future_provider/pages/users/user_detail_page.dart';
import 'package:future_provider/pages/users/users_providers.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.watch(userListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: userList.when(
        data: (users) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            separatorBuilder: (BuildContext context, int index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.username),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => UserDetailPage(
                        userId: index,
                      ),
                    ),
                  );
                },
              );
            },
            itemCount: users.length,
          );
        },
        error: (e, st) {
          return Center(
            child:
                Text(e.toString(), style: const TextStyle(color: Colors.red)),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
