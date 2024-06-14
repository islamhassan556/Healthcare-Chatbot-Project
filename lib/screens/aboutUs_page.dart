
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    // Determine the image path based on the current locale
    String imagePath = Localizations.localeOf(context).languageCode == 'ar'
        ? "images/about_us.AR.png"
        : "images/aboutus.png";

    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff1D5879),
                  Color(0xff04141D),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.2, 0.85],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 50),
              Image.asset(imagePath),
              Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.about_us1,
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                    SizedBox(height: 15),
                    Text(
                      AppLocalizations.of(context)!.about_us2,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)!.about_us3,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
