// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_chatbot/screens/login_page.dart';
import 'package:healthcare_chatbot/widget/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// Custom Text Field widget
class CustemTextField extends StatelessWidget {
  final String? hintText;
  final Icon prefixIcon;
  final Function(String)? onChanged;

  const CustemTextField({
    Key? key,
    this.hintText,
    this.onChanged,
    required this.prefixIcon,
  }) : super(key: key);

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

// Custom Password Field widget
class CustemPasswordField extends StatefulWidget {
  final String? hintText;
  final Icon prefixIcon;
  final Function(String)? onChanged;

  const CustemPasswordField({
    Key? key,
    this.hintText,
    this.onChanged,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  _CustemPasswordFieldState createState() => _CustemPasswordFieldState();
}

class _CustemPasswordFieldState extends State<CustemPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 60,
      child: TextField(
        onChanged: widget.onChanged,
        obscureText: _obscureText,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: 20),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          filled: true,
          fillColor: Color(0xffF0F0F0),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? confirmPassword;
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30, top: 30),
                      child: Center(
                        child: Text(
                            AppLocalizations.of(context)!.register,

                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      AppLocalizations.of(context)!.registe_to_con,

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
                        firstName = data;
                      },
                      hintText: AppLocalizations.of(context)!.first_name,
                      prefixIcon: Icon(
                        Icons.person,
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustemTextField(
                      onChanged: (data) {
                        lastName = data;
                      },
                      hintText: AppLocalizations.of(context)!.last_name,
                      prefixIcon: Icon(
                        Icons.person,
                        size: 35,
                        color: Colors.black,
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
                      height: 25,
                    ),
                    CustemPasswordField(
                      onChanged: (data) {
                        confirmPassword = data;
                      },
                      hintText: AppLocalizations.of(context)!.confirm_password,
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    CustomButton(
                      onTap: () async {
                        if (password != confirmPassword) {
                          // Passwords do not match, show a message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)!.pswd_match_err,
                              ),
                            ),
                          );
                          return;
                        }

                        setState(() {
                          isLoading = true;
                        });

                        try {
                          UserCredential user = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email!,
                            password: password!,
                          );
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.user!.uid)
                              .set({
                            'firstName': firstName,
                            'lastName': lastName,
                            'email': email,
                          });

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(context)!.pswd_weak,
                                ),
                              ),
                            );
                          } else if (e.code == 'email-already-in-use') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(context)!
                                      .email_already_used,
                                ),
                              ),
                            );
                          }
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      text: AppLocalizations.of(context)!.register,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.already_have_acc,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.signin,
                            style: TextStyle(
                                fontSize: 18, color: Color(0xff050522)),
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
