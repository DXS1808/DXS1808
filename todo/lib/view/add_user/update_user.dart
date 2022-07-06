import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/allert_dropdown/allert_dopdown.dart';
import 'package:todo/component/pick_image/pick_image.dart';
import 'package:todo/component/rouned_button.dart';
import 'package:todo/view/add_user/user_avatar/avatar.dart';
import '../../component/input_text_wrap.dart';
import '../../constants/constants.dart';
import '../../model/user_profile.dart';

class TodoUpdate extends StatefulWidget {
  UserProfile userProfile;

  TodoUpdate(this.userProfile);

  @override
  State<TodoUpdate> createState() => _TodoUpdateState();
}

class _TodoUpdateState extends State<TodoUpdate> {
  TextEditingController name = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController address = TextEditingController();

  TextEditingController job = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController description = TextEditingController();


  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // String? imageFile;

  @override
  void initState() {
    name.text = widget.userProfile.name;
    phone.text = widget.userProfile.phone;
    address.text = widget.userProfile.address;
    job.text = widget.userProfile.job;
    age.text = widget.userProfile.age;
    if(widget.userProfile.description != null){
      description.text = widget.userProfile.description!;
    }
    // imageFile = widget.todoList.imgUrl;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.BACKGROUND_COLOR,
          title: const Text(
            "Update User",
            style: TextStyle(fontFamily: Constants.FONTFAMILY),
          ),
        ),
        body: Form(
          key: _key,
          child: SingleChildScrollView(
            child:Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Avatar(100, 100, widget.userProfile.imgUrl),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 20,
                              color: Constants.BACKGROUND_COLOR,
                            ),
                            onPressed: () {
                              PickImage.imagePicker(context).then((value) {
                                setState(() {
                                  widget.userProfile.imgUrl = value!.path;
                                });
                              });
                            },
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  inputName(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  inputAddress(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  inputPhone(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  inputJob(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  inputAge(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  inputDescription(),
                  const SizedBox(height: 30.0),
                  buttonUpdate(context),
                ],
              ),
            ),
          ),
        ));
  }

  inputName() {
    return InputTextWrap(
      label: "Name...",
      controller: name,
      icon: const Icon(
        Icons.edit_outlined,
        size: 20,
        color: Constants.BACKGROUND_COLOR,
      ),
      obscureText: false,
      validator: (str) {
        return null;
      },
    );
  }

  inputPhone() {
    RegExp regExp = RegExp(r'^(84|0[3|5|7|8|9])+([0-9]{8})\b');
    return InputTextWrap(
      label: "Phone...",
      controller: phone,
      icon: const Icon(
        Icons.phone,
        size: 20,
        color: Constants.BACKGROUND_COLOR,
      ),
      obscureText: false,
      validator: (str) {
        if (regExp.hasMatch(str!) == false) {
          return "Enter valid phone";
        }
        return null;
      },
    );
  }

  inputAddress() {
    return InputTextWrap(
      label: "Address...",
      controller: address,
      icon: const Icon(
        Icons.location_on_outlined,
        size: 20,
        color: Constants.BACKGROUND_COLOR,
      ),
      obscureText: false,
      validator: (str) {
        return null;
      },
    );
  }
  inputAge() {
    return InputTextWrap(
      label: "Age...",
      controller: age,
      icon: const Icon(
        Icons.edit_outlined,
        size: 20,
        color: Constants.BACKGROUND_COLOR,
      ),
      obscureText: false,
      validator: (str) {
        if (str!.isEmpty) {
          return "Age is required";
        }
        return null;
      },
    );
  }
  inputDescription() {
    return InputTextWrap(
      label: "Description...",
      controller: description,
      icon: const Icon(
        Icons.edit_outlined,
        size: 20,
        color: Constants.BACKGROUND_COLOR,
      ),
      obscureText: false,
      validator: (str) {
        if (str!.isEmpty) {
          return "Age is required";
        }
        return null;
      },
    );
  }

  inputJob() {
    return InputTextWrap(
      label: "Job...",
      controller: job,
      icon: const Icon(
        Icons.edit_outlined,
        size: 20,
        color: Constants.BACKGROUND_COLOR,
      ),
      obscureText: false,
      validator: (str) {
        if (str!.isEmpty) {
          return "Job is required";
        }
        return null;
      },
    );
  }

  buttonUpdate(BuildContext context) {
    return RounedButton(
        onPress: () {
          editTodo(widget.userProfile, name.text, phone.text, address.text,
                  widget.userProfile.imgUrl, job.text,age.text,description.text)
              .then((value) {
            AllertDropdown.success("Update Success");
            Navigator.pushNamed(context, "/homeScreen");
          });
        },
        text: "Update");
  }

  Future editTodo(UserProfile userProfile, String name, String phone, String address,
      String imgUrl, String job,String age,String description) async {
    userProfile.name = name;
    userProfile.phone = phone;
    userProfile.address = address;
    userProfile.imgUrl = imgUrl;
    userProfile.job = job;
    userProfile.age = age;
    userProfile.description = description;
    await userProfile.save();
  }
}
