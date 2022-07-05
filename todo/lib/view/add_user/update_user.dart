import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo/component/pick_image/pick_image.dart';
import 'package:todo/component/rouned_button.dart';
import '../../component/input_text_wrap.dart';
import '../../constants/constants.dart';
import '../../model/todo_list.dart';

class TodoUpdate extends StatefulWidget {
  TodoList todoList;

  TodoUpdate(this.todoList);

  @override
  State<TodoUpdate> createState() => _TodoUpdateState();
}

class _TodoUpdateState extends State<TodoUpdate> {
  TextEditingController name = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController address = TextEditingController();

  TextEditingController job = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();


  String? imageFile;

  @override
  void initState() {
    name.text = widget.todoList.name;
    phone.text = widget.todoList.phone;
    address.text = widget.todoList.address;
    job.text = widget.todoList.job;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.backgroundColor,
        title: const Text(
          "Update User",
          style: TextStyle(fontFamily: Constants.fontFamily),
        ),
      ),
      body: Form(
        key: _key,
        child: Container(
          padding:const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipOval(
                    child: Image.file(
                      File(widget.todoList.imgUrl),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt_outlined,
                        size: 20,
                        color: Constants.backgroundColor,),
                        onPressed: (){
                          PickImage.imagePicker(context).then((value){
                            setState(() {
                              imageFile = value!.path;
                            });
                          });
                        },
                      )
                  ),
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
              const SizedBox(height: 30.0),
              buttonUpdate(),
            ],
          ),
        ),
      )
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
    RegExp regExp = RegExp(r'^(84|0[3|5|7|8|9])+([0-9]{8})\b');
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
        if (str!.isEmpty) {
          return "Job is required";
        }
        return null;
      },
    );
  }

  buttonUpdate() {
    return RounedButton(onPress: () {}, text: "Update");
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
