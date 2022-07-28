import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data_sources/local_storage/boxes.dart';
import 'package:todo/model/user_profile.dart';

class UserCubit extends Cubit<UsersProfile> {
  UserCubit()
      : super(UsersProfile(Boxes.todos(FirebaseAuth.instance.currentUser!.uid)
            .reversed
            .toList()));

  addUser(List<UserProfile> userProfile) {
    emit(UsersProfile(userProfile.reversed.toList()));
  }

}

class UsersProfile {
  List<UserProfile> listUserProfile;

  UsersProfile(this.listUserProfile);
}
