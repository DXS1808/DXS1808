import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/constants/constants.dart';
import 'package:todo/view/task_screen/user_list.dart';
import '../local_storage/boxes.dart';
import '../model/user_profile.dart';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Todo List",
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Constants.BACKGROUND_COLOR,
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
                                width: 300,
                                child: AlertDialog(
                                  contentPadding: const EdgeInsets.all(0),
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: const ListTile(
                                          leading: Icon(Icons.person_pin),
                                          title: Text("View Profile"),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          logout();
                                        },
                                        child: const ListTile(
                                          leading: Icon(Icons.logout),
                                          title: Text("Log out"),
                                        ),
                                      )
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
              child: ValueListenableBuilder<Box<UserProfile>>(
                  valueListenable: Boxes.getTodos().listenable(),
                  builder: (context, todos, _) {
                    return UserScreenList(todos.values.toList());
                  }),
            ),
            Positioned(bottom: 10,left: size.width/3, child: addUser())
          ],
        ));
  }

  void logout() async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Navigator.pushNamed(context, "/login"));
  }

  Widget addUser() {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        print(Boxes.todos);
        Navigator.push(context, _createRoute());
      },
      child: Container(
        // width: size.width,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: Constants.BACKGROUND_COLOR.withOpacity(0.6)),
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
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddUser(),
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
