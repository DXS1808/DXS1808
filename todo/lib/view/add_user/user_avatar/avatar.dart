import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/avatar_cubit.dart';



class Avatar extends StatelessWidget {
  double height;
  double width;
  Avatar(this.height,this.width);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocAvatar,String>(
        builder: (context, state){
          return state == "" ?const CircleAvatar(
            maxRadius: 30,
          ):ClipOval(
            child: Image.file(
              File(state),
              height: height,
              width: width,
              fit: BoxFit.cover,
            ),
          );
    });
  }
}
