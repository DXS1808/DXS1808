
import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: 0)
class Account extends HiveObject {
  @HiveField(0)
  late String email;
  @HiveField(1)
  late String password;

  Account(this.email,this.password);

  // factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
  //
  // Map<String,dynamic> toJson() => _$UserToJson(this);

}

