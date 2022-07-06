import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/allert_dropdown/allert_dopdown.dart';
import 'package:todo/component/input_text_wrap.dart';
import '../../local_storage/boxes.dart';
import '../../component/rouned_button.dart';
import '../../constants/constants.dart';
import '../../model/account.dart';
import '../../router/router.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _passwordVisible = true;
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Material(
        child: ValueListenableBuilder<Box<Account>>(
          valueListenable: Boxes.getUsers().listenable(),
          builder: (context, box, _) {
            return Form(
                key: _key,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/login.png",
                          ),
                          fit: BoxFit.cover)
                    // gradient: LinearGradient(colors: [
                    //   Color(0xff79D0C0),
                    //   Color(0xffFFFFFF),
                    // ], begin: Alignment.topLeft, end: Alignment.bottomRight)
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height / 5,
                        ),
                        const Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        inputUserName(box.values.toList()),
                        const SizedBox(
                          height: 10.0,
                        ),
                        inputPassword(box.values.toList()),
                        const SizedBox(
                          height: 50.0,
                        ),
                        loginButton(box.values.toList(), context),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have account?",
                              style: TextStyle(
                                  fontSize: Constants.FONTSIZE,
                                  fontFamily: Constants.FONTFAMILY
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/signup");
                                // print(users);
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Constants.BACKGROUND_COLOR,
                                    fontSize: Constants.FONTSIZE,
                                    fontFamily: Constants.FONTFAMILY
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }

  inputUserName(List<Account> users) {
    var input = RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
    return InputTextWrap(
        label: "Email...",
        controller: email,
        obscureText: false,
        icon: const Icon(
          Icons.person_outline,
          size: 20,
          color: Constants.BACKGROUND_COLOR,
        ),
        validator: (str) {
          if (input.hasMatch(str!) == false && str.isNotEmpty) {
            return "Wrong email format";
          } else if (str.isEmpty) {
            return "Email is required";
          }
          // else if(users.isNotEmpty){
          //   for(int i =0 ;i<= users.length-1;i++){
          //     if(str != users[i].email) {
          //       return "Password or Email wrong";
          //     }
          //   }
          // }
          return null;
        });
  }

  inputPassword(List<Account> users) {
    return InputTextWrap(
        label: "Password...",
        controller: password,
        icon: const Icon(
          Icons.lock_outline,
          size: 15,
          color: Constants.BACKGROUND_COLOR,
        ),
        obscureText: _passwordVisible,
        iconSuffix: GestureDetector(
          child: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible ? Icons.visibility_off : Icons.visibility,
            color: Constants.BACKGROUND_COLOR,
          ),
          onTap: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        validator: (str) {
          if (str!.isEmpty) {
            return "Password is required";
          }
          // else if(users.isNotEmpty){
          //   for(int i =0 ;i<= users.length-1;i++){
          //     if(str != users[i].password) {
          //       return "Password or Email wrong";
          //     }
          //   }
          // }
          return null;
          // else if(str.isNotEmpty){
          //   for(var user in users){
          //     if(str != user.password) {
          //       return "Password or Email wrong";
          //     }
          //   }
          // }
        });
  }

  loginButton(List<Account> users, BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return RounedButton(
      onPress: () {
              getUser();
        if (_key.currentState!.validate()) {
          signInUser(context).then((value) {
           AllertDropdown.success("Login Success");
          }).onError((error, stackTrace){
            AllertDropdown.error("Login failed. Email or password is wrong");
          });
          // for (int i = 0; i <= users.length - 1; i++) {
          //   if (users[i].email == email.value.text &&
          //       users[i].password == password.value.text) {
          //     AllertDropdown.success("Login Success");
          //     Navigator.pushNamed(context, "/homeScreen");
          //   }
          // }
        }
      },
      text: 'Login',
    );
  }

  void getUser() async{
   try{
     if(FirebaseAuth.instance.currentUser != null){
       print(FirebaseAuth.instance.currentUser!.email);
     }
   }catch(e){
     print(e);
   }
  }

  Future<void> signInUser(BuildContext context) async {
    try {
     await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.text, password: password.text);
      if (!mounted) return;
      Navigator.pushNamed(context, AppRouter.homeScreen);
    }on FirebaseAuthException catch (e){
      print(e);
    }
  }

  @override
  void dispose() {
    email.clear();
    password.clear();
    Hive.close();
    super.dispose();
  }

}
