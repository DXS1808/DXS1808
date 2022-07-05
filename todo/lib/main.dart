import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/bloc/avatar_cubit.dart';
import 'package:todo/model/user_profile.dart';
import 'package:todo/model/account.dart';
import 'package:todo/router/router.dart';
import 'package:todo/view/login/login_screen.dart';


 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(AccountAdapter());
  Hive.registerAdapter(UserProfileAdapter());

  await Hive.openBox<Account>("account");
  await Hive.openBox<UserProfile>("usersProfile");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late StreamSubscription<User?> user;

  @override
  void initState() {
    // TODO: implement initState
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<BlocAvatar>(create: (BuildContext context) => BlocAvatar())
        ],
        child: MaterialApp(
          initialRoute: FirebaseAuth.instance.currentUser == null ? AppRouter.loginAuth : AppRouter.homeScreen,
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
