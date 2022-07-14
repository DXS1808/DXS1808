import '../../model/user_profile.dart';

abstract class UserRepository {
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
  );

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
      String urlTelegram);
}
