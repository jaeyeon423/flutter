import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("list1"),
      trailing: Checkbox(value: false, onChanged: null),
    );
  }
}
