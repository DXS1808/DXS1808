import 'package:flutter/material.dart';
import 'package:todo/model/user_profile.dart';
import 'package:todo/presentation/view/task_screen/user_detail.dart';
import '../../../config/constants/constants.dart';
import '../../component/dialog.dart';
import '../../component/text_item.dart';
import '../add_user/update_user.dart';
import '../add_user/user_avatar/avatar.dart';

class UserItem extends StatefulWidget {
  UserProfile userProfile;

  UserItem(this.userProfile);

  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.tealAccent.withOpacity(0.4),
      elevation: 5.0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: TextButton(
        style: ButtonStyle(backgroundColor:
            MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Constants.kBackgroundColor.withOpacity(0.2);
          }
          return Colors.white; // Use the component's default.
        }), foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.tealAccent.withOpacity(0.5);
            }
            return Colors.white; // Use the component's default.
          },
        )),
        onPressed: () {
          Navigator.push(context, _createRouteDetail());
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Text(widget.todoList.imgUrl),
                  Avatar(60, 60, widget.userProfile.imgUrl),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextItem(content: widget.userProfile.name),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          TextItem(content: "${widget.userProfile.address}, "),
                          TextItem(content: widget.userProfile.age)
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
                      text: "Edit",
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, _createRoute());
                      },
                      child: const Icon(Icons.edit,
                          color: Constants.kBackgroundColor, size: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Tooltip(
                    richMessage: const TextSpan(
                      text: "Delete",
                    ),
                    child: GestureDetector(
                      onTap: () {
                        ShowDialog(
                            content: "Do you want delete item?",
                            press: () {
                              deleteTodo(widget.userProfile);
                              Navigator.of(context, rootNavigator: true).pop();
                            }).show(context);
                      },
                      child: const Icon(Icons.delete,
                          color: Constants.kBackgroundColor, size: 20),
                    ),
                  ),
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
