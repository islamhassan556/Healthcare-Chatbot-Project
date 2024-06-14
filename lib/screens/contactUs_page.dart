// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}
class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  stops: [0.2, 0.85]),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                ),
                Container(
                    width: 200,
                    height: 200,
                    child: Image.asset(
                      "images/Contactus.png",
                      fit: BoxFit.contain,
                    )),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.contact_us,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on, color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                AppLocalizations.of(context)!.sohag_city,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.phone, color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                "+201148034668",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.attach_email_rounded,
                                color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                "Ahmed@gmail.com",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        )
                      ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
