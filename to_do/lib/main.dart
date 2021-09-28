import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "to do app",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Todo List"),
        ),
        body: TodoList(),
      ),
    );
  }
}


class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> todos = [];
  _toggleTodo(Todo todo, bool isChecked) {
    todo.isDone = isChecked;
  }

  Widget _buildItem(BuildContext context, int index){
    final todo = todos[index];

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: _buildItem, itemCount: todos.length,);
  }
}

class Todo {
  Todo({this.title="", this.isDone = false});

  String title;
  bool isDone;
}

