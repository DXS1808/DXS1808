import '../model/user_profile.dart';
import 'boxes.dart';


class UserLocal {
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
      String userId) async {
    final userProfile = UserProfile(name, phone, address, imgUrl, job, age,
        description, urlFacebook, urlTelegram)
      ..name = name
      ..phone = phone
      ..address = address
      ..imgUrl = imgUrl
      ..job = job
      ..age = age
      ..description = description
      ..urlFacebook = urlFacebook
      ..urlTelegram = urlTelegram;

    await Boxes.getTodos(userId).add(userProfile);
  }
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
      String urlTelegram) async {
    userProfile.name = name;
    userProfile.phone = phone;
    userProfile.address = address;
    userProfile.imgUrl = imgUrl;
    userProfile.job = job;
    userProfile.age = age;
    userProfile.description = description;
    userProfile.urlFacebook = urlFacebook;
    userProfile.urlTelegram = urlTelegram;
    await userProfile.save();
  }
  Future delete(UserProfile userProfile) async {
    await userProfile.delete();
  }
}