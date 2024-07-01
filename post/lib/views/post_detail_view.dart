import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/post_detail_viewmodel.dart';
import '../models/post.dart';

class PostDetailView extends StatelessWidget {
  final Post post;

  PostDetailView({required this.post});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostDetailViewModel()..loadPost(post),
      child: Scaffold(
        appBar: AppBar(
          title: Text(post.title),
        ),
        body: Consumer<PostDetailViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.post == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(viewModel.post!.content),
              );
            }
          },
        ),
      ),
    );
  }
}
