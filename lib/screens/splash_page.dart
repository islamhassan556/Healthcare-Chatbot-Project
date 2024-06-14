// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_chatbot/screens/chatbot_page.dart';
import 'package:healthcare_chatbot/screens/onboarding_page1.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
super.initState();
    Timer(
      Duration(seconds: 2), // Change the duration as needed
      () {
        FirebaseAuth.instance.authStateChanges().listen((user) {
          if (user != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => ChatbotPage()),
            );
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => OnboardingPage1()),
            );
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff1C5271),
                  Color(0xff040E15),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                // stops: [0.02, 0.95]
              ),
            ),
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/Splash_chatgpt robot.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
