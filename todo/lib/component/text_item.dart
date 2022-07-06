import 'package:flutter/cupertino.dart';

import '../constants/constants.dart';

class TextItem extends StatelessWidget {
  String content;
  TextItem({Key? key,required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: const TextStyle(
          fontFamily: Constants.FONTFAMILY,
          fontSize: 12,
          color: Constants.TEXTCOLOR,
          fontWeight: Constants.FONTWEIGHT,
      ),
    );
  }
}
