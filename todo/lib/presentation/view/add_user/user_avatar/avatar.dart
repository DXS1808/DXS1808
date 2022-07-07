import 'dart:io';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  double height;
  double width;
  String imgUrl;
  Avatar(this.height,this.width,this.imgUrl);
  @override
  Widget build(BuildContext context) {
    return ClipOval(
            child: Image.file(
              File(imgUrl),
              height: height,
              width: width,
              fit: BoxFit.cover,
              errorBuilder: (context, object, stackTrace) {
                return ClipOval(
                  child: Image.asset("assets/images.png",
                  width: width,
                    height: height,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          );
  }
}
