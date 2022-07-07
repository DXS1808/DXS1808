import 'package:flutter/cupertino.dart';

import '../../presentation/view/home_screen.dart';
import '../../presentation/view/login/login_screen.dart';
import '../../presentation/view/login/signup_screen.dart';
import '../../presentation/view/splash.dart';



class AppRouter {
  static const String loginAuth = "/login";
  static const String homeScreen = "/homeScreen";
  static const String signup = "/signup";
  static const String splash = "/splash";

  static Map<String,WidgetBuilder> define ={
    splash:(context) => const Splash(),
    loginAuth:(context)=>LoginScreen(),
    homeScreen:(context) => HomeScreen(),
    signup:(context) => SignUpScreen(),
  };
}