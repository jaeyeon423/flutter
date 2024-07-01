import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/post_list_viewmodel.dart';
import 'post_detail_view.dart';

class PostListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Consumer<PostListViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.posts.length,
            itemBuilder: (context, index) {
              final post = viewModel.posts[index];
              return ListTile(
                title: Text(post.title),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetailView(post: post),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<PostListViewModel>().fetchPosts();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
