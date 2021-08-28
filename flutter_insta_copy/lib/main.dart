import 'package:flutter/material.dart';
import 'package:flutter_insta_copy/pages/HomePage.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuddiesGram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData
        (
        scaffoldBackgroundColor: Colors.black,
        dialogBackgroundColor: Colors.black,
        primarySwatch: Colors.grey,
        accentColor: Colors.black,
        cardColor: Colors.white70,
      ),
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
