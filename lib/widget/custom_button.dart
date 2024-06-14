

// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  CustomButton({this.onTap,required this.text});
  VoidCallback? onTap;
  String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xff050522),
        ),
        width: 280,
        height: 60,
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: Color(0xffF2D365), fontSize: 25),
        )),
      ),
    );
  }
}