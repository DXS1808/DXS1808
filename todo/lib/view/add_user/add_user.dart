import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/allert_dropdown/allert_dopdown.dart';
import 'package:todo/bloc/user_cubit.dart';
import 'package:todo/component/pick_image/pick_image.dart';
import 'package:todo/component/rouned_button.dart';
import '../../component/input_text_wrap.dart';
import '../../constants/constants.dart';
import '../../local_storage/boxes.dart';
import '../../model/todo_list.dart';

class AddUser extends StatefulWidget {
  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController name = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController address = TextEditingController();

  TextEditingController job = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  String pathImage = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          backgroundColor: Constants.backgroundColor,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            children: [
              pathImage == ""
                  ? imagePiker(context)
                  : Container(
                      height: 80,
                      width: 80,
                      child: ClipRRect(
                        child: Image.file(
                          File(pathImage),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
              const SizedBox(height: 20.0,),
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
              const SizedBox(height: 30.0),
              buttonAddUser()
            ],
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
        color: Constants.backgroundColor,
      ),
      obscureText: false,
      validator: (str) {
        return null;
      },
    );
  }

  inputPhone() {
    return InputTextWrap(
      label: "Phone...",
      controller: phone,
      icon: const Icon(
        Icons.phone,
        size: 20,
        color: Constants.backgroundColor,
      ),
      obscureText: false,
      validator: (str) {
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
        color: Constants.backgroundColor,
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
        color: Constants.backgroundColor,
      ),
      obscureText: false,
      validator: (str) {
        return null;
      },
    );
  }

  imagePiker(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _picker
            .pickImage(
          source: ImageSource.gallery,
          maxHeight: Constants.MAX_HEIGHT,
          maxWidth: Constants.MAX_WIDTH,
          imageQuality: Constants.IMAGE_QUALITY,
        )
            .then((value) {
          setState(() {
            pathImage == value?.path ;
          });
          print("$pathImage");
        }).onError((error, stackTrace) => AllertDropdown.error("Picker failed"));
      },
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
        child: const Icon(
          Icons.camera_alt_outlined,
          color: Constants.backgroundColor,
        ),
      ),
    );
  }

  buttonAddUser() {
    return RounedButton(onPress: () {}, text: "Add User");
  }

  Future addTodo(String name, String phone, String address, String imgUrl,
      String job) async {
    final todo = TodoList(name, phone, address, imgUrl, job)
      ..name = name
      ..phone = phone
      ..address = address
      ..imgUrl = imgUrl
      ..job = job;

    final box = Boxes.getTodos();
    await box.add(todo);
    // box.put("account",user);
    // box.put("password", password);
  }

  deleteTodo(TodoList todoList) {
    todoList.delete();
  }

  editTodo(TodoList todoList, String name, String phone, String address,
      String imgUrl, String job) {
    todoList.name = name;
    todoList.phone = phone;
    todoList.address = address;
    todoList.imgUrl = imgUrl;
    todoList.job = job;
    todoList.save();
  }
}
