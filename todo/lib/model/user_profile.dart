
import 'package:hive/hive.dart';

part 'user_profile.g.dart';
@HiveType(typeId: 1)
class UserProfile extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String phone;
  @HiveField(2)
  String address;
  @HiveField(3)
  String imgUrl;
  @HiveField(4)
  String job;
  @HiveField(5)
  String age;
  @HiveField(6)
  String ? description;

  UserProfile(this.name,this.phone,this.address,this.imgUrl,this.job,this.age,this.description);
}