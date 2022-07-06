import 'package:flutter/material.dart';
import 'package:todo/constants/constants.dart';

class AllertDropDown extends StatelessWidget {
  String state;
  AllertDropDown({Key? key,required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return stateCommon(state);
  }

  stateCommon(String state){
    switch(state){
      case(Constants.SUCCESS):
        return snackBar(const Icon(Icons.check,size: 20,), "Success",Colors.green );
      case(Constants.ERROR):
        return snackBar(const Icon(Icons.clear,size: 20,), "Error",Colors.red) ;
    }

  }

  Widget snackBar(Widget icon, String text, Color color){
    return Container(
        child: Row(
          children: [
            icon,
            Text(text,
              style: TextStyle(color: color),
            ),
          ],
        ));
  }
}

