import 'package:flutter/material.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new item'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
              child: Column(
            children: [
            ],
          ))),
    );
  }
}
