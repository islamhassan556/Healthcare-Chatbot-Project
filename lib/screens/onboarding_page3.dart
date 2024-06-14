// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_import
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_chatbot/screens/welcome_page.dart';
class OnboardingPage3 extends StatefulWidget {
  const OnboardingPage3({super.key});

  @override
  State<OnboardingPage3> createState() => _OnboardingPage3State();
}

class _OnboardingPage3State extends State<OnboardingPage3> {
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
              height: 70,
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
              ],
            ),
            SizedBox(
              height: 45,
            ),
            Column(
              children: [
                Text(
                 AppLocalizations.of(context)!.onboard_3_1,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  AppLocalizations.of(context)!.onboard_3_2,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WelcomePage();
                  }));
                },
                child: Text(
                 AppLocalizations.of(context)!.get_started,
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
