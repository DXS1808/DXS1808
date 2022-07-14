import 'package:todo/data_sources/repository/user_api.dart';
import 'package:todo/data_sources/repository/user_repository.dart';
import 'package:todo/model/user_profile.dart';

class UserImpl implements UserRepository {
  UserApi userApi = UserApi();
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
    return userApi.addTodo(name, phone, address, imgUrl, job, age, description, urlFacebook, urlTelegram);
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
    return userApi.editTodo(userProfile, name, phone, address, imgUrl, job, age, description, urlFacebook, urlTelegram);
  }
}
