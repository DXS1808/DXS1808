import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data_sources/local_storage/boxes.dart';
import 'package:todo/model/user_profile.dart';

class BlocUser extends Cubit<UsersProfile> {
  BlocUser() : super(UsersProfile(Boxes.todos));

  addUser(List<UserProfile> userProfile){
     emit(UsersProfile(userProfile));
  }

  
}

class UsersProfile {
  List<UserProfile> listUserProfile;
  UsersProfile(this.listUserProfile);
}

