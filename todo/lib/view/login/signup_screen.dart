import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/allert_dropdown/allert_dopdown.dart';
import 'package:todo/component/input_text_wrap.dart';
import 'package:todo/constants/constants.dart';
import '../../local_storage/boxes.dart';
import '../../component/rouned_button.dart';
import '../../model/account.dart';
import '../../router/router.dart';

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
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Constants.BACKGROUND_COLOR,
        ),
        body: ValueListenableBuilder<Box<Account>>(
            valueListenable: Boxes.getUsers().listenable(),
            builder: (context, box, _) {
              return Form(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height / 7,),
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
                        inputUserName(box.values.toList()),
                        const SizedBox(
                          height: 10.0,
                        ),
                        inputPassword(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        conFirmPassword(),
                        const SizedBox(
                          height: 50.0,
                        ),
                        signUpButton(context)
                      ],
                    ),
                  ),
                ),
              );
            }

        )
    );
  }

  inputUserName(List<Account> users) {
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
          if (str!.isNotEmpty) {
            if (input.hasMatch(str) == false) {
              return "Wrong email format";
            } else if (users.isNotEmpty) {
              for (int i = 0; i <= users.length - 1; i++) {
                if (users[i].email == str) {
                  return "Email already exists";
                }
              }
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
          color: Constants.BACKGROUND_COLOR,
        ),
        obscureText: passwordVisibleConfirm,
        iconSuffix: GestureDetector(
          child: Icon(
            // Based on passwordVisible state choose the icon
            passwordVisibleConfirm ? Icons.visibility_off : Icons.visibility,
            color: Constants.BACKGROUND_COLOR,
          ),
          onTap: () {
            // Update the state i.e. toogle the state of passwordVisible variable
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
    // User user = User(email.value.text,password.value.text);
    // users.add(user);

    return RounedButton(
      onPress: () {
        // _key.currentState!.save();
        if (_key.currentState!.validate()) {
          registerUser().then((value) {
            // addUser(email.value.text, password.value.text);
            AllertDropdown.success("Sign up success");
          });
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

  Future addUser(String email, String password) async {
    final user = Account(email, password)
      ..email = email
      ..password = password;

    final box = Boxes.getUsers();
    await box.add(user);
    // print(box.add(user));
    // box.put("password", password);
  }

  Future<void> registerUser() async {
    try {
     await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email.value.text.trim(), password: password.value.text.trim());
      if (!mounted) return;
      Navigator.pushNamed(context, AppRouter.homeScreen);
    }catch (e){
      print(e);
    }
  }

// void editUser(){
//
// }

// @override
// void dispose() {
//   // TODO: implement dispose
//   Hive.close();
//   super.dispose();
// }
}
