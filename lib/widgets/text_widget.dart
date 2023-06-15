import 'package:flutter/material.dart';

class TextDecoration extends StatelessWidget {
  String title;
  double fontSize;

  FontWeight ?fontWeight;
  TextDecoration( { required this.title, required this.fontSize ,
   this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Colors.white,
        ),

    );
  }
}