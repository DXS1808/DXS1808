import 'package:todo/data_sources/local_storage/user_local.dart';
import 'package:todo/domain/repository/user_repository.dart';
import 'package:todo/model/user_profile.dart';

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
      String urlTelegram) {
    // TODO: implement addTodo
    return userLocal.addTodo(name, phone, address, imgUrl, job, age, description, urlFacebook, urlTelegram);
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
}
