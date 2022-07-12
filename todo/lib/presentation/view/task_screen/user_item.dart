import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data_sources/local_storage/boxes.dart';
import 'package:todo/model/user_profile.dart';
import 'package:todo/presentation/view/task_screen/user_detail.dart';
import '../../../config/constants/constants.dart';
import '../../bloc/user_profile_cubit.dart';
import '../../component/dialog.dart';
import '../../component/text_item.dart';
import '../add_user/update_user.dart';
import '../add_user/user_avatar/avatar.dart';

class UserItem extends StatefulWidget {
  UserProfile userProfile;
  int index;

  UserItem(this.userProfile,this.index);

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(widget.todoList.imgUrl),
                  Avatar(60, 60, widget.userProfile.imgUrl),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextItem(
                          content:
                              "${widget.userProfile.name}, ${widget.userProfile.age}",
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextItem(
                          content: widget.userProfile.address,
                          maxLines: 1,
                          textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.grey.withOpacity(0.8),
                            fontFamily: Constants.kFontFamily,
                            fontSize: 12,
                            fontWeight: Constants.kFontWeight,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            TextItem(
                              content: widget.userProfile.phone,
                              textStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.8),
                                fontFamily: Constants.kFontFamily,
                                fontSize: 12,
                                fontWeight: Constants.kFontWeight,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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

  deleteTodo(UserProfile userProfile) {
    userProfile.delete();
  }

  Route _createRoute() {
    final BlocUser blocUser = context.read();
    return PageRouteBuilder(
      // pageBuilder: (context, animation, secondaryAnimation) =>
      //     TodoUpdate(widget.userProfile),
      pageBuilder: (context, animation, secondaryAnimation) =>
          BlocProvider<BlocUser>.value(
        value: blocUser,
        child: TodoUpdate(widget.userProfile),
      ),
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
