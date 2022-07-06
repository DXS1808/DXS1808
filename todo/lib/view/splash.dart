import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:todo/constants/constants.dart';
import 'package:todo/view/login/login_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: LoginScreen(),
      title: const Text('TODO LIST',textScaleFactor: 2,
      style: TextStyle(
        fontFamily: Constants.FONTFAMILY,
        fontWeight: FontWeight.w400
      ),
      ),
      image: Image.asset('assets/images.png'),
      loadingText: const Text("Loading..."),
      backgroundColor: Colors.white,
      photoSize: 100.0,
      loaderColor: Constants.BACKGROUND_COLOR,
    );
  }
}
