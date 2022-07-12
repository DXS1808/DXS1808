import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/model/user_profile.dart';
import 'package:todo/presentation/bloc/user_profile_cubit.dart';
import 'package:todo/presentation/view/search_item/search_item.dart';
import 'package:todo/presentation/view/task_screen/user_list.dart';
import '../../config/constants/constants.dart';
import '../component/dialog.dart';
import 'add_user/add_user.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  List<UserProfile> users = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<BlocUser, UsersProfile>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Todo List",
            ),
            leading: IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchItem(state.listUserProfile));
              },
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Constants.kBackgroundColor,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.person_outline,
                  size: 25,
                  color: Colors.white,
                ),
                onPressed: () {
                  final RenderBox button =
                  context.findRenderObject() as RenderBox;
                  var offset = button.localToGlobal(Offset.zero);
                  var topOffset = offset.dy + 15;
                  showDialog(
                      context: context,
                      barrierColor: Colors.white.withOpacity(0.1),
                      builder: (BuildContext context) {
                        return Stack(
                          children: [
                            Positioned(
                                top: offset.dx - 10,
                                right: topOffset - 15,
                                child: SizedBox(
                                  width: 280,
                                  child: AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    contentPadding: const EdgeInsets.all(10.0),
                                    content: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                            onTap: () {},
                                            child: Row(children: const [
                                              Icon(
                                                Icons.person_pin,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text("View Profile"),
                                            ])),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              ShowDialog(
                                                content: 'Do you want sign out ?',
                                                press: () {
                                                  logout();
                                                  Navigator.of(context,
                                                      rootNavigator: true)
                                                      .pop();
                                                },
                                              ).show(context);
                                            },
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  Icons.logout,
                                                  size: 30,
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text("Log out"),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        );
                      });
                },
              )
            ],
          ),
          body: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 50),
                // child: ValueListenableBuilder<Box<UserProfile>>(
                //     valueListenable: Boxes.getTodos().listenable(),
                //     builder: (context, todos, _) {
                //       users = todos.values.toList().reversed.toList();
                //       return UserScreenList(todos.values.toList().reversed.toList());
                //     }),
                child: UserScreenList(state.listUserProfile)
              ),
              Positioned(
                  bottom: 10, left: size.width / 3, child: addUser()),
            ],
          ));
    });
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, "/splash");
  }

  Widget addUser() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          _createRoute(),
        );
      },
      child: Container(
        // width: size.width,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: Constants.kBackgroundColor.withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.add_circle_outline_outlined,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Add User",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            )
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    final BlocUser blocUser = context.read();
    return PageRouteBuilder(
      // pageBuilder: (context, animation, secondaryAnimation) => const AddUser(),
      pageBuilder: (context, animation, secondaryAnimation) =>
          BlocProvider<BlocUser>.value(
        value: blocUser,
        // create: (context) => BlocUser(),
        child: const AddUser(),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween),
        child: child,
        );
      },
    );
  }
}
