import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo/constants/constants.dart';
import 'package:todo/view/add_user/user_avatar/avatar.dart';

import '../../model/user_profile.dart';

class TodoDetail extends StatelessWidget {
  UserProfile todoList;

  TodoDetail(this.todoList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "User Detail",
          style: TextStyle(
            fontFamily: Constants.fontFamily,
          ),
        ),
        backgroundColor: Constants.backgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            // Avatar(100,100),
            ClipOval(
                child: Image.file(
              File(todoList.imgUrl),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            )),
            const SizedBox(
              height: 10.0,
            ),
            item(
                todoList.name,
                const Icon(
                  Icons.person,
                  color: Constants.backgroundColor,
                ))
          ],
        ),
      ),
    );
  }

  Widget item(String field, Widget icon) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 10.0,
        ),
        Text(
          field,
          style: const TextStyle(fontFamily: Constants.fontFamily),
        )
      ],
    );
  }
}
