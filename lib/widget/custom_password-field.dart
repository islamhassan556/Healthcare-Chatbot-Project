// ignore_for_file: prefer_const_constructors, use_super_parameters, sized_box_for_whitespace, must_be_immutable

import 'package:flutter/material.dart';
class CustemTextField extends StatelessWidget {
  final String? hintText;
  final Icon prefixIcon;

   CustemTextField({
    Key? key,
    this.onChanged,
    this.hintText,
    required this.prefixIcon,
  }) : super(key: key);
Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 60,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 20),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          filled: true,
          fillColor: Color(0xffF0F0F0),
        ),
      ),
    );
  }
}