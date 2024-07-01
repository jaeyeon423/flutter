import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/post_list_viewmodel.dart';
import 'views/post_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostListViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter MVVM Board',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PostListView(),
      ),
    );
  }
}
