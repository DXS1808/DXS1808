import 'package:flutter/cupertino.dart';
import 'package:todo/view/task_screen/todo_item.dart';

import '../../model/user_profile.dart';

class TodoScreenList extends StatelessWidget {
  List<UserProfile> todoList;
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
