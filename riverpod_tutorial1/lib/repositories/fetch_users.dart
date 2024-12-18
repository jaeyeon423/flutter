import 'package:dio/dio.dart';
import 'package:riverpod_tutorial1/models/user.dart';

Future<List<User>> fetchUsers() async {
  try {
    final Response response =
        await Dio().get('https://jsonplaceholder.typicode.com/users');

    final List userList = response.data;
    // print(userList[0]);

    final users = [for (final user in userList) User.fromMap(user)];

    print(users[0]);
    return users;
  } catch (e) {
    rethrow;
  }
}
