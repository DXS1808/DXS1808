import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo/constants/constants.dart';
import 'package:todo/view/add_user/user_avatar/avatar.dart';

import '../../model/user_profile.dart';

class UserDetail extends StatelessWidget {
  UserProfile userProfile;

  UserDetail(this.userProfile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "User Detail",
            style: TextStyle(
              fontFamily: Constants.fontFamily,
            ),
          ),
          backgroundColor: Constants.backgroundColor,
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Constants.backgroundColor.withOpacity(0.8)),
                ),
                Positioned(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        // Avatar(100,100),
                        ClipOval(
                            child: Image.file(
                          File(userProfile.imgUrl),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          userProfile.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: Constants.fontFamily,
                          ),
                        ),

                        Container(
                          padding:const EdgeInsets.fromLTRB(0, 5.0, 0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 20,
                                color: Constants.backgroundColor,
                              ),
                              const SizedBox(width: 8.0,),
                              Text(
                                userProfile.address,
                                style: const TextStyle(fontFamily: Constants.fontFamily),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding:const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.phone,
                                size: 20,
                                color: Constants.backgroundColor,
                              ),
                              const SizedBox(width: 8.0,),
                              Text(userProfile.phone,
                                style: const TextStyle(fontFamily: Constants.fontFamily),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: category("Age", "${userProfile.age} year"),
                ),

                Expanded(
                  child: category("Job", userProfile.job),
                )
              ],
            ),
          ],
        ));
  }

  Widget category(String title, String content) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
              fontFamily: Constants.fontFamily,
              fontWeight: FontWeight.w100,
              fontSize: 14),
        ),
        Text(
          content,
          style:
              const TextStyle(fontFamily: Constants.fontFamily, fontSize: 16),
        )
      ],
    );
  }

// Widget item(String field, Widget icon) {
//   return Row(
//     children: [
//       icon,
//       const SizedBox(
//         width: 10.0,
//       ),
//       Text(
//         field,
//         style: const TextStyle(fontFamily: Constants.fontFamily),
//       )
//     ],
//   );
// }
}
