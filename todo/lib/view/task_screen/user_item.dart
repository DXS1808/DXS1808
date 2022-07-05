import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/constants/constants.dart';
import 'package:todo/model/user_profile.dart';
import 'package:todo/view/add_user/user_avatar/avatar.dart';
import 'package:todo/view/task_screen/user_detail.dart';
import 'package:todo/view/add_user/update_user.dart';

class UserItem extends StatefulWidget {
  UserProfile userProfile;

  UserItem(this.userProfile);

  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          Navigator.push(context, _createRouteDetail());
      },
      child: Card(
        color: Constants.backgroundColor.withOpacity(0.5),
        elevation: 5.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Text(widget.todoList.imgUrl),
                  ClipOval(
                    child: Image.file(
                      File(widget.userProfile.imgUrl),
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Avatar(60,60),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userProfile.name,
                        style: const TextStyle(
                          fontFamily: Constants.fontFamily,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            "${widget.userProfile.address}, ",
                            style: const TextStyle(
                              fontFamily: Constants.fontFamily,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            widget.userProfile.age,
                            style: const TextStyle(
                              fontFamily: Constants.fontFamily,
                              fontSize: 12,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Tooltip(
                    richMessage: const TextSpan(
                      text: "Delete",
                    ),
                    child: GestureDetector(
                      onTap: (){
                        deleteTodo(widget.userProfile);
                      },
                      child: const Icon(Icons.delete,
                      size: 20),
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  Tooltip(
                    richMessage: const TextSpan(
                      text: "Edit",
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, _createRoute());
                      },
                      child: const Icon(Icons.edit,
                          size: 20),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  deleteTodo(UserProfile todoList) {
    todoList.delete();
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          TodoUpdate(widget.userProfile),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
  Route _createRouteDetail() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
         UserDetail(widget.userProfile),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
