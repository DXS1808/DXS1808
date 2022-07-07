import 'package:flutter/material.dart';
import '../../../config/constants/constants.dart';
import '../../../model/user_profile.dart';
import '../../component/web_view.dart';
import '../add_user/user_avatar/avatar.dart';

class UserDetail extends StatelessWidget {
  UserProfile userProfile;

  UserDetail(this.userProfile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "User Profile",
            style: TextStyle(
              fontFamily: Constants.kFontFamily,
            ),
          ),
          backgroundColor: Constants.kBackgroundColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: Constants.kBackgroundColor.withOpacity(0.8)),
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
                          Avatar(100, 100, userProfile.imgUrl),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            userProfile.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: Constants.kFontFamily,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 20,
                                  color: Constants.kBackgroundColor,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  userProfile.address,
                                  style: const TextStyle(
                                      fontFamily: Constants.kFontFamily),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.phone,
                                  size: 20,
                                  color: Constants.kBackgroundColor,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  userProfile.phone,
                                  style: const TextStyle(
                                      fontFamily: Constants.kFontFamily),
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
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (userProfile.urlFacebook != null &&
                        userProfile.urlFacebook!.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          MaterialPageRoute webView = MaterialPageRoute(
                              builder: (context) =>
                                  PreviewWeb(url: userProfile.urlFacebook!));
                          Navigator.push(context, webView);
                        },
                        child: const Icon(
                          Icons.facebook,
                          size: 40,
                          color: Constants.kBackgroundColor,
                        ),
                      ),
                    const SizedBox(
                      width: 20,
                    ),
                    if (userProfile.urlTelegram != null &&
                        userProfile.urlTelegram!.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          MaterialPageRoute webView = MaterialPageRoute(
                              builder: (context) =>
                                  PreviewWeb(url: userProfile.urlTelegram!));
                          Navigator.push(context, webView);
                        },
                        child: const Icon(
                          Icons.telegram,
                          size: 40,
                          color: Constants.kBackgroundColor,
                        ),
                      )
                  ],
                ),
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
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const Text(
                  "About me",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: Constants.kFontFamily),
                ),
              ),
              const Divider(
                endIndent: 10.0,
                indent: 10.0,
                color: Constants.kBackgroundColor,
              ),
              if (userProfile.description != null)
                Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    elevation: 5.0,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        userProfile.description!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: Constants.kFontFamily,
                            fontWeight: Constants.kFontWeight),
                      ),
                    ))
            ],
          ),
        ));
  }

  Widget category(String title, String content) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
              fontFamily: Constants.kFontFamily,
              fontWeight: FontWeight.w100,
              fontSize: 14),
        ),
        Text(
          content,
          style:
              const TextStyle(fontFamily: Constants.kFontFamily, fontSize: 16),
        )
      ],
    );
  }
}
