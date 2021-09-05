import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add Task",
              style: TextStyle(fontSize: 30.0, color: Colors.lightBlueAccent),
              textAlign: TextAlign.center,
            ),
            TextField(
              textAlign: TextAlign.center,
              autofocus: true,
            ),
            TextButton(
              onPressed: () {
                //add out task to the list.
              },
              child: Text("Add"),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.lightBlueAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
