// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:healthcare_chatbot/models/message.dart';

class PatientBublle extends StatelessWidget {
  const PatientBublle({
    super.key,
    required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              padding:
                  EdgeInsets.only(left: 16, top: 25, bottom: 25, right: 16),
              decoration: BoxDecoration(
                  color: Color(0xff006184),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                      )),
                      
              child: Text(
                message.message,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          Image.asset("images/profile.png", height: 55),
          Padding(
            padding: EdgeInsets.only(left: 4),
          ),
        ],
      ),
    );
  }
}
