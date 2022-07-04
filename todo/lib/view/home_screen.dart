import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/bloc/user_cubit.dart';
import 'package:todo/component/input_text_wrap.dart';
import 'package:todo/component/rouned_button.dart';
import 'package:todo/constants/constants.dart';
import 'package:todo/view/task_screen/todo_list.dart';

import '../local_storage/boxes.dart';
import '../model/todo_list.dart';
import '../model/user.dart';
import 'add_user/add_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Todo List",
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Constants.backgroundColor,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.person_outline,
                size: 20,
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
                                          Navigator.pushNamed(
                                              context, "/login");
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
              margin: const EdgeInsets.only(top: 50),
              child: ValueListenableBuilder<Box<TodoList>>(
                  valueListenable: Boxes.getTodos().listenable(),
                  builder: (context, todos, _) {
                    return TodoScreenList(todos.values.toList());
                  }),
            ),
            Positioned(bottom: 0, child: addUser())
          ],
        ));
  }

  Widget addUser() {
    BlocCheck provider = context.read();
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          // do something
          return AddUser();
        }));
      },
      child: Container(
        width: size.width,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: Constants.backgroundColor.withOpacity(0.6)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.add_circle_outline_outlined,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(
                width: 20,
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
}
