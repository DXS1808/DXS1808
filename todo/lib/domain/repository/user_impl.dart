
import 'package:todo/domain/repository/user_repository.dart';

import '../../data/local_storage/user_local.dart';
import '../../data/model/user_profile.dart';

class UserImpl implements UserRepository {
  UserLocal userLocal = UserLocal();
  @override
  Future addTodo(
      String name,
      String phone,
      String address,
      String imgUrl,
      String job,
      String age,
      String description,
      String urlFacebook,
      String urlTelegram,
      String userId
      ) {
    // TODO: implement addTodo
    return userLocal.addTodo(name, phone, address, imgUrl, job, age, description, urlFacebook, urlTelegram,userId);
  }

  @override
  Future editTodo(
      UserProfile userProfile,
      String name,
      String phone,
      String address,
      String imgUrl,
      String job,
      String age,
      String description,
      String urlFacebook,
      String urlTelegram) {
    // TODO: implement editTodo
    return userLocal.editTodo(userProfile, name, phone, address, imgUrl, job, age, description, urlFacebook, urlTelegram);
  }

  @override
  Future delete(UserProfile userProfile) {
    // TODO: implement delete
    return userLocal.delete(userProfile);
  }
}
