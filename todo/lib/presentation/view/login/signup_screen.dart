import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../config/constants/constants.dart';
import '../../../core/router/router.dart';
import '../../component/allert_dropdown/allert_dopdown.dart';
import '../../component/input_text_wrap.dart';
import '../../component/rouned_button.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  var input = RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}');

  bool _passwordVisible = true;
  bool passwordVisibleConfirm = true;

  // var box = Hive.box("user");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Material(
        child: Form(
                key: _key,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/login.png'),
                          fit: BoxFit.cover)
                    // gradient: LinearGradient(colors: [
                    //   Constants.backgroundColor,
                    //   Color(0xffFFFFFF),
                    // ], begin: Alignment.topLeft, end: Alignment.bottomRight)
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height / 4,),
                        const Text(
                          "SignUp",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        inputUserName(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        inputPassword(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        conFirmPassword(),
                        const SizedBox(
                          height: 30.0,
                        ),
                        signUpButton(context),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('You have account ? '),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, "/login");
                              },
                              child : const Text(
                                "Sign in",
                                style:TextStyle(
                                  color: Constants.kBackgroundColor,
                                  decoration: TextDecoration.underline
                                ) ,
                              )
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )

    );
  }

  inputUserName() {
    return InputTextWrap(
        label: "Email...",
        controller: email,
        obscureText: false,
        icon: const Icon(
          Icons.person_outline,
          size: 20,
          color: Constants.kBackgroundColor,
        ),
        validator: (str) {
          if (str!.isNotEmpty) {
            if (input.hasMatch(str) == false) {
              return "Wrong email format";
            }
          } else {
            return "Email is required";
          }
        });
  }

  inputPassword() {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return InputTextWrap(
        label: "Password...",
        controller: password,
        icon: const Icon(
          Icons.lock_outline,
          size: 20,
          color: Constants.kBackgroundColor,
        ),
        obscureText: _passwordVisible,
        iconSuffix: GestureDetector(
          child: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible ? Icons.visibility_off : Icons.visibility,
            color: Constants.kBackgroundColor,
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
          // else if (!regex.hasMatch(str)) {
          //   return "Enter valid password";
          // }
          return null;
        });
  }

  conFirmPassword() {
    return InputTextWrap(
        label: "ConfirmPassword...",
        controller: confirmPassword,
        icon: const Icon(
          Icons.lock_outline,
          size: 20,
          color: Constants.kBackgroundColor,
        ),
        obscureText: passwordVisibleConfirm,
        iconSuffix: GestureDetector(
          child: Icon(
            passwordVisibleConfirm ? Icons.visibility_off : Icons.visibility,
            color: Constants.kBackgroundColor,
          ),
          onTap: () {
            setState(() {
              passwordVisibleConfirm = !passwordVisibleConfirm;
            });
          },
        ),
        validator: (str) {
          if (str!.isNotEmpty) {
            if (str != password.text) {
              return "Incorrect Password";
            }
          } else if (str.isEmpty) {
            return "Confirm Password is required";
          }
          return null;
        });
  }

  signUpButton(BuildContext context) {
    return RounedButton(
      onPress: () {
        if (_key.currentState!.validate()) {
          registerUser();
          // addUser(email.value.text, password.value.text).then((value) {
          //   // blocUser.user(email.value.text, password.value.text);
          //   AllertDropdown.success("Sign up success");
          //   Navigator.pushNamed(context, "/login");
          // });
          // box.put("account", email.value.text);
          // box.put("password", password.value.text);
        }
      },
      text: 'Sign up',
    );
  }
  // Future addUser(String email, String password) async {
  //   final user = Account(email, password)
  //     ..email = email
  //     ..password = password;
  //
  //   final box = Boxes.getUsers();
  //   await box.add(user);
  // }

  Future registerUser() async {
    try {
     await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email.value.text.trim(), password: password.value.text.trim());
     AlertDropdown.success("Sign up success");
      Navigator.pushNamed(context, AppRouter.homeScreen);
    } catch (e){
      AlertDropdown.error(e.toString());
    }
  }

}
