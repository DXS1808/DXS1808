import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/model/user_profile.dart';
import 'package:todo/presentation/bloc/user_profile_cubit.dart';
import 'package:todo/presentation/view/home_screen.dart';
import 'package:todo/presentation/view/splash.dart';

import 'core/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDirectory.path);
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(UserProfileAdapter());
  await Hive.openBox<UserProfile>(
      "usersProfile_${FirebaseAuth.instance.currentUser?.uid}");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      routes: AppRouter.define,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) => Stack(
        children: [child!, const DropdownAlert()],
      ),
      // home: const MainPage()
      home: MultiBlocProvider(
        providers: [
          BlocProvider<UserCubit>(create: (BuildContext context) => UserCubit())
        ],
        child: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
          } else if (snapshot.hasData) {
            return HomeScreen();
          }
          return const Splash();
        });
  }
}
