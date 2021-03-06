
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  RoundedButton({required this.onPress,required this.text});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPress,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(10.0),
          elevation: 5.0,
        backgroundColor:const Color(0xff79D0C0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // <-- Radius
        ),

    primary: Colors.white,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
