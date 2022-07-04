import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/model/todo_list.dart';

class BlocTodo extends Cubit<TodoList> {
  BlocTodo() : super(TodoList("", "", "", "",""));

  addTodo(String name, String phone, String address, String imgUrl,String job) {
    emit(TodoList(name, phone, address, imgUrl,job));
  }
}

