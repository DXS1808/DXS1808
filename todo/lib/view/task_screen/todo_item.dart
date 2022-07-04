import 'package:flutter/material.dart';
import 'package:todo/model/todo_list.dart';

class TodoItem extends StatefulWidget {
  TodoList todoList;
  TodoItem(this.todoList);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Card(

    );
  }
}
