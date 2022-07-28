
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/bloc/user_profile_cubit.dart';

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
    homeScreen:(context) {
      return  BlocProvider<UserCubit>(
        create:(context) => UserCubit(),
        child: HomeScreen() ,
      );
    },
    signup:(context) => SignUpScreen(),
  };
}