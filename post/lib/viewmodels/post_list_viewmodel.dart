import 'package:flutter/material.dart';
import '../models/post.dart';

class PostListViewModel extends ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  void fetchPosts() {
    // 여기서는 더미 데이터를 사용합니다. 실제 앱에서는 API 호출이 필요합니다.
    _posts = [
      Post(id: 1, title: 'First Post', content: 'This is the first post content'),
      Post(id: 2, title: 'Second Post', content: 'This is the second post content'),
    ];
    notifyListeners();
  }
}
