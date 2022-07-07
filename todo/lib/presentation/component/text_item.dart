import 'package:flutter/cupertino.dart';

import '../../config/constants/constants.dart';


class TextItem extends StatelessWidget {
  String content;
  TextItem({Key? key,required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: const TextStyle(
          fontFamily: Constants.kFontFamily,
          fontSize: 12,
          color: Constants.kTextColor,
          fontWeight: Constants.kFontWeight,
      ),
    );
  }
}
