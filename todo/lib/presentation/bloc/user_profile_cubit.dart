import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/model/user_profile.dart';

class BlocTodo extends Cubit<List<UserProfile>> {
  BlocTodo(List<UserProfile> list) : super(list);

  addTodo() {
    emit(state);
  }
}

