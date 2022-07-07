
import 'package:flutter/material.dart';

import '../../config/constants/constants.dart';

class ShowDialog {
  String content;
  VoidCallback press;
  ShowDialog({Key?key,required this.content, required this.press});
  show(BuildContext context){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        contentPadding:const EdgeInsets.all(10.0),
        content: Text(content,
          style: const TextStyle(
            fontWeight: Constants.FONTWEIGHT,
          ),
        ),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(context,rootNavigator: true).pop();
            },
            child:const Text("Cancel",
            style: TextStyle(
              color: Constants.BACKGROUND_COLOR
            ),),
          ),
          TextButton(
            onPressed: press,
            child:const Text("OK",
            style: TextStyle(
              color: Constants.BACKGROUND_COLOR
            ),
            ),
          )
        ],
      );
    });
  }
}