import 'package:hive/hive.dart';

import '../../model/account.dart';
import '../../model/user_profile.dart';

class Boxes {
  static Box<Account> getUsers() => Hive.box<Account>('account');

  static List<Account> users = Boxes.getUsers().values.toList();

  static Box<UserProfile> getTodos() => Hive.box<UserProfile>("usersProfile");

  static List<UserProfile> todos = Boxes.getTodos().values.toList();
  // static Box getName() => Hive.box("username");
}