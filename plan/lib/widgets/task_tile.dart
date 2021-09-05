import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "list1",
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: TaskCheckbox(
        checkboxState: isChecked,
        toggleCheckboxState: (bool? checkboxState) {
          setState(() {
            if (checkboxState != null) isChecked = checkboxState;
          });
        },
      ),
    );
  }
}

class TaskCheckbox extends StatelessWidget {
  final bool checkboxState;
  final void Function(bool?) toggleCheckboxState;

  TaskCheckbox(
      {required this.checkboxState, required this.toggleCheckboxState});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.lightBlueAccent,
      value: checkboxState,
      onChanged: toggleCheckboxState,
    );
  }
}
