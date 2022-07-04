import 'package:flutter/cupertino.dart';
import 'package:todo/view/task_screen/todo_item.dart';

import '../../model/todo_list.dart';

class TodoScreenList extends StatelessWidget {
  List<TodoList> todoList;
  TodoScreenList(this.todoList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todoList.length,
        itemBuilder: (context,index){
        return TodoItem(todoList[index]);
    });
  }
}
