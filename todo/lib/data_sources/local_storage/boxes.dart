
import 'package:hive/hive.dart';
import '../../model/user_profile.dart';

class Boxes {
  static Box<UserProfile> getTodos(String userId) =>
      Hive.box<UserProfile>("usersProfile_$userId");

  static List<UserProfile> todos(String userId) =>
      Boxes.getTodos(userId).values.toList();
// static Box getName() => Hive.box("username");
}
