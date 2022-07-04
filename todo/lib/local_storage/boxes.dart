import 'package:hive/hive.dart';

import '../model/todo_list.dart';
import '../model/user.dart';

class Boxes {
  static Box<User> getUsers() => Hive.box<User>('account');

  static List<User> users = Boxes.getUsers().values.toList();

  static Box<TodoList> getTodos() => Hive.box<TodoList>("todos");

  static List<TodoList> todos = Boxes.getTodos().values.toList();
  // static Box getName() => Hive.box("username");
}