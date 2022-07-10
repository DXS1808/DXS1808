import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:splashscreen/splashscreen.dart';

import '../../config/constants/constants.dart';
import 'login/login_screen.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // WidgetsFlutterBinding.ensureInitialized();
    // await Hive.initFlutter();
    // Hive.registerAdapter(AccountAdapter());
    // Hive.registerAdapter(UserProfileAdapter());
    // await Hive.openBox<UserProfile>("usersProfile");
    // await Hive.openBox<Account>("account");
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: LoginScreen(),
      title: const Text('TODO LIST',textScaleFactor: 2,
      style: TextStyle(
        fontFamily: Constants.kFontFamily,
        fontWeight: FontWeight.w400
      ),
      ),
      image: Image.asset('assets/images.png'),
      loadingText: const Text("Loading..."),
      backgroundColor: Colors.white,
      photoSize: 100.0,
      loaderColor: Constants.kBackgroundColor,
    );
  }
}