
import 'package:hive/hive.dart';

part 'todo_list.g.dart';
@HiveType(typeId: 1)
class TodoList extends HiveObject {
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

  TodoList(this.name,this.phone,this.address,this.imgUrl,this.job);

  // factory TodoList.fromJson(Map<String,dynamic> json) => _$TodoListFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$TodoListToJson(this);

}