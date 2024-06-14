// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, use_build_context_synchronously, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_chatbot/screens/congrats_page.dart';
import 'package:healthcare_chatbot/screens/register_page.dart';
import 'package:healthcare_chatbot/widget/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  bool isLoading = false;
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
          Container(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      AppLocalizations.of(context)!.enter_email_pass,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustemTextField(
                      onChanged: (data) {
                        email = data;
                      },
                      hintText: AppLocalizations.of(context)!.email,
                      prefixIcon: Icon(
                        Icons.email,
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    CustemPasswordField(
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: AppLocalizations.of(context)!.pass,
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                      onTap: () async {
                        if(email!=null&&password!=null&&email!.isNotEmpty&&password!.isNotEmpty){
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          UserCredential user = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email!,
                            password: password!,
                          );
                
                          // Retrieve user data from Firestore
                
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CongratsPage(),
                            ),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found' ||
                              e.code == 'wrong-password') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(AppLocalizations.of(context)!.invalid_email_pass),
                              ),
                            );
                          } else if (e.code == 'invalid-email') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(AppLocalizations.of(context)!.invalid_email_format),
                              ),
                            );
                          }
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                        }
                      },
                      text: AppLocalizations.of(context)!.login,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.no_acc,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'registerPage');
                          },
                          child: Text(
                           AppLocalizations.of(context)!.then_signup,
                            style:
                                TextStyle(fontSize: 18, color: Color(0xff050522)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          isLoading
              ? Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
