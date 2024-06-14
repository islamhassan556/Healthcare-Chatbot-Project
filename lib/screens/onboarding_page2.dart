// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_import
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_chatbot/screens/onboarding_page3.dart';
class OnboardingPage2 extends StatefulWidget {
  const OnboardingPage2({super.key});
  @override
  State<OnboardingPage2> createState() => _OnboardingPage2State();
}
class _OnboardingPage2State extends State<OnboardingPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xff1D5879),
                  Color(0xff04141D),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.2, 0.85]),
          ),
        ),
        ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
                height: 420,
                width: 400,
                child: Image.asset(
                  "images/onboarding-photo.png",
                  fit: BoxFit.cover,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: Icon(
                    Icons.circle,
                    color: Colors.white,
                    size: 17,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: Icon(
                    Icons.rectangle_rounded,
                    color: Colors.black,
                    size: 22,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: Icon(
                    Icons.circle,
                    color: Colors.white,
                    size: 17,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 12),
              child: Text(
                AppLocalizations.of(context)!.onboard_2,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return OnboardingPage3();
                  }));
                },
                child: Text(
                  AppLocalizations.of(context)!.next,
                  style: TextStyle(color: Color(0xffFFE96D), fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff050522),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
