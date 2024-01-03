import 'package:flutter/material.dart';

class TmpScreen extends StatefulWidget {
  const TmpScreen({super.key});

  @override
  State<TmpScreen> createState() => _TmpScreenState();
}

class _TmpScreenState extends State<TmpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Groceries'),
      ),
    );
  }
}
