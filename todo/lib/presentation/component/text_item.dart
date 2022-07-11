import 'package:flutter/cupertino.dart';

import '../../config/constants/constants.dart';


class TextItem extends StatelessWidget {
  final String content;
  final TextStyle? textStyle;
  final int? maxLines;
  TextItem({required this.content,this.textStyle,this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines:maxLines,
      content,
      softWrap: true,
      style: textStyle ?? const TextStyle(
        fontFamily: Constants.kFontFamily,
        fontSize: 12,
        color: Constants.kTextColor,
        fontWeight: Constants.kFontWeight,
      ),
    );
  }
}
