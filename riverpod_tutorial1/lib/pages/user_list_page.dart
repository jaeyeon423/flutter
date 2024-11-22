// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:riverpod_tutorial1/models/user.dart';
import 'package:riverpod_tutorial1/pages/user_details_page.dart';
import 'package:riverpod_tutorial1/repositories/fetch_users.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<User> users = [];
  String error = "";
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() async {
    try {
      setState(() {
        loading = true;
      });
      users = await fetchUsers();
      error = '';
    } catch (e) {
      error = e.toString();
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error.isEmpty
              ? ListUsers(users: users)
              : buildError(),
    );
  }

  Widget buildError() => Center(
          child: Column(
        children: [
          Text(
            error,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          OutlinedButton(
            onPressed: _fetchUsers,
            child: const Text('Retry'),
          )
        ],
      ));
}

class ListUsers extends StatelessWidget {
  final List<User> users;
  const ListUsers({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final user = users[index];

          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailsPage(user: user),
                ),
              );
            },
            leading: CircleAvatar(
              child: Text(user.id.toString()),
            ),
            title: Text(user.name),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: users.length);
  }
}
