import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/presentation/bloc/user_profile_cubit.dart';
import '../../../config/constants/constants.dart';
import '../../../data_sources/local_storage/boxes.dart';
import '../../../domain/repository/user_impl.dart';
import '../../component/allert_dropdown/allert_dopdown.dart';
import '../../component/input_text_wrap.dart';
import '../../component/pick_image/pick_image.dart';
import '../../component/rouned_button.dart';
import 'user_avatar/avatar.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

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
  TextEditingController urlFacebook = TextEditingController();
  TextEditingController urlTelegram = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  UserImpl userCall = UserImpl();

  UserCubit ? blocUser;

  @override
  void initState() {
    blocUser = BlocProvider.of<UserCubit>(context);
    // TODO: implement initState
    super.initState();
  }


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
          backgroundColor: Constants.kBackgroundColor,
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
                      ? uploadImage((str) {
                        if(str == null){
                          return "Upload Image is required";
                        }
                        return null;
                  })
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
                                    color: Constants.kBackgroundColor,
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
                  const SizedBox(
                    height: 10.0,
                  ),
                  inputUrlFacebook(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  inputUrlTelegram(),
                  const SizedBox(height: 30.0),
                  RoundedButton(
                      onPress: () {
                        if (_key.currentState!.validate()) {
                          userCall.addTodo(
                              name.text,
                              phone.text,
                              address.text,
                              imagePath!,
                              job.text,
                              age.text,
                              description.text,
                              urlFacebook.text,
                              urlTelegram.text,
                              FirebaseAuth.instance.currentUser!.uid
                          )
                              .then((value) {
                            blocUser?.addUser(Boxes.todos(FirebaseAuth.instance.currentUser!.uid));
                            AlertDropdown.success("Add user success");
                            clear();
                          });
                        }
                      },
                      text: "Add User")
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
          return "This field is required";
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
        return null;
        // if (str!.isEmpty) {
        //   return "Description is required";
        // }
        // return null;
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
        return null;
      },
    );
  }

  Widget uploadImage(String? Function(XFile?)? validator) {
    return FormField<XFile>(
        validator: validator,
        builder: (formFieldState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          GestureDetector(
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
                color: Constants.kBackgroundColor,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
          if (formFieldState.hasError)
            Text(
              formFieldState.errorText!,
              style:const TextStyle(fontSize: 14, color: Colors.red),
            ),
            ],
          );
        });
  }


  // buttonAddUser() {
  //   BlocUser blocUser = context.watch<BlocUser>();
  //   return RounedButton(
  //       onPress: () {
  //         if (_key.currentState!.validate()) {
  //           addTodo(
  //                   name.text,
  //                   phone.text,
  //                   address.text,
  //                   imagePath!,
  //                   job.text,
  //                   age.text,
  //                   description.text,
  //                   urlFacebook.text,
  //                   urlTelegram.text)
  //               .then((value) {
  //                 blocUser.addUser(Boxes.todos);
  //             AllertDropdown.success("Add user success");
  //             clear();
  //           });
  //         }
  //       },
  //       text: "Add User");
  // }


  clear() {
    name.clear();
    address.clear();
    phone.clear();
    job.clear();
    age.clear();
    description.clear();
    urlFacebook.clear();
    urlTelegram.clear();
    setState(() {
      imagePath = null;
    });
  }
}
