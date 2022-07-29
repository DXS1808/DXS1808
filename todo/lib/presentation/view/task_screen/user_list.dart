import 'package:flutter/cupertino.dart';
import 'package:todo/presentation/view/task_screen/user_item.dart';

import '../../../data/model/user_profile.dart';



class UserScreenList extends StatelessWidget {
  final List<UserProfile> userList;
  const UserScreenList(this.userList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userList.length,
        itemBuilder: (context,index){
        return UserItem(userList[index],index);
    });
  }
}
