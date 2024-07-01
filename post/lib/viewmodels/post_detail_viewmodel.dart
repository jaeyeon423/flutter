import 'package:flutter/material.dart';
import '../models/post.dart';

class PostDetailViewModel extends ChangeNotifier {
  Post? _post;

  Post? get post => _post;

  void loadPost(Post post) {
    _post = post;
    notifyListeners();
  }
}
