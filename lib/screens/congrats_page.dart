// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, prefer_const_literals_to_create_immutables, must_be_immutable, override_on_non_overriding_member, annotate_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_chatbot/screens/chatbot_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class CongratsPage extends StatefulWidget {
  CongratsPage({
    super.key,
  });

  @override
  State<CongratsPage> createState() => _CongratsPageState();
}
class _CongratsPageState extends State<CongratsPage> {
  String Name = '';
  @override
  getName() async {
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    Name = await userData['firstName'];

    setState(() {});
  }
  void initState() {
    // TODO: implement initState
    getName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xff1C5271),
                Color(0xff040E15),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.02, 0.95]),
        ),
        child: Center(
          child: Container(
            alignment: Alignment.center,
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, top: 60),
                  height: 340,
                  child: Image.asset(
                    "images/congrats.gif",
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Text(
                    "${AppLocalizations.of(context)!.hello} ${Name}",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    AppLocalizations.of(context)!.thank_msg,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ChatbotPage();
                      }));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.continuee,
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
          ),
        ),
      ),
    );
  }
}
