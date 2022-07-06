import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo/allert_dropdown/allert_dopdown.dart';
import 'package:todo/component/pick_image/pick_image.dart';
import 'package:todo/component/rouned_button.dart';
import 'package:todo/view/add_user/user_avatar/avatar.dart';
import '../../component/input_text_wrap.dart';
import '../../constants/constants.dart';
import '../../local_storage/boxes.dart';
import '../../model/user_profile.dart';

class AddUser extends StatefulWidget {
  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController name = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController address = TextEditingController();

  TextEditingController job = TextEditingController();

  TextEditingController age = TextEditingController();
  TextEditingController description = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Material(
          child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Add User",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Constants.BACKGROUND_COLOR,
        ),
        body: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                children: [
                  imagePath == null
                      ? imagePicker(context)
                      : Stack(
                          children: [
                            Avatar(100, 100, imagePath!),
                            Positioned(
                                bottom: 10,
                                right: 18,
                                child: GestureDetector(
                                  onTap: () {
                                    PickImage.imagePicker(context)
                                        .then((value) {
                                      setState(() {
                                        imagePath = value!.path;
                                      });
                                    });
                                  },
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Constants.BACKGROUND_COLOR,
                                  ),
                                ))
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
                  buttonAddUser()
                ],
              ),
            ),
          ),
        ),
      )),
    );
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
          return "Description is required";
        }
        return null;
      },
    );
  }

  imagePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PickImage.imagePicker(context).then((value) {
          setState(() {
            imagePath = value!.path;
            // print(value);
          });
        });
      },
      child: CircleAvatar(
        maxRadius: 50,
        backgroundColor: Colors.grey.withOpacity(0.1),
        child: const Icon(
          Icons.camera_alt_outlined,
          color: Constants.BACKGROUND_COLOR,
        ),
      ),
    );
  }

  buttonAddUser() {
    // String? url = imageFile != null ? imageFile!.path : null;
    return RounedButton(
        onPress: () {
          if (_key.currentState!.validate()) {
            addTodo(name.text, phone.text, address.text, imagePath!, job.text,
                    age.text, description.text)
                .then((value) {
              AllertDropdown.success("Add user success");
              clear();
            });
          }
        },
        text: "Add User");
  }

  Future addTodo(String name, String phone, String address, String imgUrl,
      String job, String age, String description) async {
    final userProfile =
        UserProfile(name, phone, address, imgUrl, job, age, description)
          ..name = name
          ..phone = phone
          ..address = address
          ..imgUrl = imgUrl
          ..job = job
          ..age = age
          ..description = description;

    final box = Boxes.getTodos();
    await box.add(userProfile);
    // box.put("account",user);
    // box.put("password", password);
  }

  clear() {
    name.clear();
    address.clear();
    phone.clear();
    job.clear();
    age.clear();
    description.clear();
    setState(() {
      imagePath = null;
    });
  }
}
