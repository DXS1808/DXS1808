
import 'package:flutter/material.dart';
import 'package:todo/presentation/component/rouned_button.dart';

import '../../config/constants/constants.dart';

class ShowDialog {
  String content;
  VoidCallback press;
  ShowDialog({Key?key,required this.content, required this.press});
  show(BuildContext context){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        contentPadding:const EdgeInsets.all(10.0),
        content: Text(content,
          style: const TextStyle(
            fontWeight: Constants.kFontWeight,
          ),
        ),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(context,rootNavigator: true).pop();
            },
            child:const Text("Cancel",
            style: TextStyle(
              color: Constants.kBackgroundColor
            ),),
          ),
          TextButton(
            onPressed: press,
            child:const Text("OK",
            style: TextStyle(
              color: Constants.kBackgroundColor
            ),
            ),
          )
        ],
      );
    });
  }
}