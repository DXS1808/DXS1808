import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/model/user_profile.dart';

class BlocTodo extends Cubit<UserProfile> {
  BlocTodo() : super(UserProfile("", "", "", "",""));

  addTodo(String name, String phone, String address, String imgUrl,String job) {
    emit(UserProfile(name, phone, address, imgUrl,job));
  }
}

