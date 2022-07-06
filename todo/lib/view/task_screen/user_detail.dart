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
              fontFamily: Constants.FONTFAMILY,
            ),
          ),
          backgroundColor: Constants.BACKGROUND_COLOR,
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
                      color: Constants.BACKGROUND_COLOR.withOpacity(0.8)),
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
                        Avatar(100,100,userProfile.imgUrl),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          userProfile.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: Constants.FONTFAMILY,
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
                                color: Constants.BACKGROUND_COLOR,
                              ),
                              const SizedBox(width: 8.0,),
                              Text(
                                userProfile.address,
                                style: const TextStyle(fontFamily: Constants.FONTFAMILY),
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
                                color: Constants.BACKGROUND_COLOR,
                              ),
                              const SizedBox(width: 8.0,),
                              Text(userProfile.phone,
                                style: const TextStyle(fontFamily: Constants.FONTFAMILY),
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
              fontFamily: Constants.FONTFAMILY,
              fontWeight: FontWeight.w100,
              fontSize: 14),
        ),
        Text(
          content,
          style:
              const TextStyle(fontFamily: Constants.FONTFAMILY, fontSize: 16),
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
