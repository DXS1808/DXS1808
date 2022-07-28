import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/constants/constants.dart';

class InputTextWrap extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Widget icon;
  final Widget? iconSuffix;
  final bool obscureText;
  final String? Function(String?) validator;
  final List<TextInputFormatter> ? inputFormatters;

 InputTextWrap(
      {required this.label,
      required this.controller,
      required this.icon,
      required this.validator,
      this.iconSuffix,
        this.inputFormatters,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15.0),
          labelStyle: const TextStyle(color: Constants.kBackgroundColor),
          labelText: label,
          prefixIcon: icon,
          suffixIcon: iconSuffix,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide:
                BorderSide(color: Constants.kBackgroundColor, width: 1.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide:
                BorderSide(color: Constants.kBackgroundColor, width: 1.0),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(
              color: Color(0xff79D0C0),
            ),
          )),
      validator: validator,
    );
  }
}
