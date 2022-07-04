import 'package:flutter/cupertino.dart';
import 'package:todo/view/add_user/add_user.dart';
import 'package:todo/view/home_screen.dart';
import 'package:todo/view/login/login_screen.dart';
import 'package:todo/view/login/signup_screen.dart';

class AppRouter {
  static const String loginAuth = "/login";
  static const String homeScreen = "/homeScreen";
  static const String signup = "/signup";
  static const String adduser = "/adduser";

  static Map<String,WidgetBuilder> define ={
    loginAuth:(context)=>LoginScreen(),
    homeScreen:(context) => HomeScreen(),
    signup:(context) => SignUpScreen(),
  };
}