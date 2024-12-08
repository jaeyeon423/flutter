// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:future_provider/pages/users/users_providers.dart';
import 'package:future_provider/user.dart';

class UserDetailPage extends ConsumerWidget {
  final int userId;
  const UserDetailPage({
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetail = ref.watch(userDetailProvider(userId));
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Detail'),
        ),
        body: userDetail.when(
          data: (user) {
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(userDetailProvider(userId)),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const Divider(),
                  UserInfo(Icons.account_circle, user.name, context),
                  SizedBox(height: 10),
                  UserInfo(Icons.email, user.email, context),
                  SizedBox(height: 10),
                  UserInfo(Icons.phone_enabled, user.phone, context),
                  SizedBox(height: 10),
                  UserInfo(Icons.web_rounded, user.website, context),
                ],
              ),
            );
          },
          error: (e, st) {
            return Center(
              child:
                  Text(e.toString(), style: const TextStyle(color: Colors.red)),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        ));
  }

  Row UserInfo(IconData icondata, String userinfo, BuildContext context) {
    return Row(
      children: [
        Icon(icondata),
        const SizedBox(width: 10),
        Text(
          userinfo,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
