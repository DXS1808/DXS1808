import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data_sources/local_storage/boxes.dart';
import 'package:todo/data_sources/repository/user_impl.dart';
import 'package:todo/presentation/bloc/user_profile_cubit.dart';
import 'package:todo/presentation/view/home_screen.dart';
import '../../../config/constants/constants.dart';
import '../../../model/user_profile.dart';
import '../../component/allert_dropdown/allert_dopdown.dart';
import '../../component/input_text_wrap.dart';
import '../../component/pick_image/pick_image.dart';
import '../../component/rouned_button.dart';
import 'user_avatar/avatar.dart';


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

  TextEditingController urlFacebook = TextEditingController();
  TextEditingController urlTelegram = TextEditingController();
  UserImpl userImpl = UserImpl();

  BlocUser ? blocUser;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // String? imageFile;

  @override
  void initState() {
    name.text = widget.userProfile.name;
    phone.text = widget.userProfile.phone;
    address.text = widget.userProfile.address;
    job.text = widget.userProfile.job;
    age.text = widget.userProfile.age;
    if (widget.userProfile.description != null) {
      description.text = widget.userProfile.description!;
    }
    if (widget.userProfile.urlFacebook != null) {
      urlFacebook.text = widget.userProfile.urlFacebook!;
    }
    if (widget.userProfile.urlTelegram != null) {
      urlTelegram.text = widget.userProfile.urlTelegram!;
    }
    blocUser = context.read();
    // imageFile = widget.todoList.imgUrl;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.kBackgroundColor,
          title: const Text(
            "Update User",
            style: TextStyle(fontFamily: Constants.kFontFamily),
          ),
        ),
        body: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                              Icons.camera_alt,
                              size: 20,
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
                  const SizedBox(
                    height: 10.0,
                  ),
                  inputUrlFacebook(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  inputUrlTelegram(),
                  const SizedBox(height: 30.0),
                  buttonUpdate(),
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
        color: Constants.kBackgroundColor,
      ),
      obscureText: false,
      validator: (str) {
        if(str!.isEmpty){
          return "Name is required";
        }
        return null;
      },
    );
  }

  inputPhone() {
    RegExp regExp = RegExp(r'^(84|0[3|5|7|8|9])+([0-9]{8})\b');
    return InputTextWrap(
      label: "Phone...",
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
      controller: phone,
      icon: const Icon(
        Icons.phone,
        size: 20,
        color: Constants.kBackgroundColor,
      ),
      obscureText: false,
      validator: (str) {
        if(str!.isEmpty){
          return "Enter valid phone";
        }
        return null;
      }
      //   if (regExp.hasMatch(str!) == false) {
      //     return "Enter valid phone";
      //   }
      //   return null;
      // },
    );
  }

  inputAddress() {
    return InputTextWrap(
      label: "Address...",
      controller: address,
      icon: const Icon(
        Icons.location_on_outlined,
        size: 20,
        color: Constants.kBackgroundColor,
      ),
      obscureText: false,
      validator: (str) {
        if(str!.isEmpty){
          return "Address is required";
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
        color: Constants.kBackgroundColor,
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
      label: "Tell Us About Yourself ...",
      controller: description,
      icon: const Icon(
        Icons.edit_outlined,
        size: 20,
        color: Constants.kBackgroundColor,
      ),
      obscureText: false,
      validator: (str) {
        if (str!.isEmpty) {
          return "This Field is required";
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
        color: Constants.kBackgroundColor,
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

  inputUrlFacebook() {
    return InputTextWrap(
      label: "Link Facebook...",
      controller: urlFacebook,
      icon: const Icon(
        Icons.link,
        size: 25,
        color: Constants.kBackgroundColor,
      ),
      obscureText: false,
      validator: (str) {
        // if (str!.isEmpty) {
        //   return "Description is required";
        // }
        return null;
      },
    );
  }

  inputUrlTelegram() {
    return InputTextWrap(
      label: "Link Telegram...",
      controller: urlTelegram,
      icon: const Icon(
        Icons.link,
        size: 25,
        color: Constants.kBackgroundColor,
      ),
      obscureText: false,
      validator: (str) {
        // if (str!.isEmpty) {
        //   return "Description is required";
        // }
        return null;
      },
    );
  }

  buttonUpdate() {
    return RounedButton(
        onPress: () {
          userImpl.editTodo(
                  widget.userProfile,
                  name.text,
                  phone.text,
                  address.text,
                  widget.userProfile.imgUrl,
                  job.text,
                  age.text,
                  description.text,
                  urlFacebook.text,
                  urlTelegram.text)
              .then((value) {
                blocUser?.addUser(Boxes.todos);
            AlertDropdown.success("Update Success");
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return BlocProvider<BlocUser>.value(
                  value: blocUser!,
                  // create: (context) => BlocUser(),
                  child: HomeScreen());
            }));
          });
        },
        text: "Update");
  }

  // Future editTodo(
  //     UserProfile userProfile,
  //     String name,
  //     String phone,
  //     String address,
  //     String imgUrl,
  //     String job,
  //     String age,
  //     String description,
  //     String urlFacebook,
  //     String urlTelegram) async {
  //   userProfile.name = name;
  //   userProfile.phone = phone;
  //   userProfile.address = address;
  //   userProfile.imgUrl = imgUrl;
  //   userProfile.job = job;
  //   userProfile.age = age;
  //   userProfile.description = description;
  //   userProfile.urlFacebook = urlFacebook;
  //   userProfile.urlTelegram = urlTelegram;
  //   await userProfile.save();
  // }
}
