import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('splash Screen'),
      ),
      body: const Center(
        child: Text('Logged in!!'),
      ),
    );
  }
}
