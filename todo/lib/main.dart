import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/bloc/user_cubit.dart';
import 'package:todo/model/todo_list.dart';
import 'package:todo/model/user.dart';
import 'package:todo/router/router.dart';
import 'package:todo/view/login/login_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>("account");
  await Hive.openBox<TodoList>("todos");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<BlocCheck>(create: (BuildContext context) => BlocCheck())
        ],
        child: MaterialApp(
          title: 'Todo List',
          routes: AppRouter.define,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          builder: (context, child) => Stack(
            children: [child!, const DropdownAlert()],
          ),
          home: LoginScreen(),
        ));
  }
}
