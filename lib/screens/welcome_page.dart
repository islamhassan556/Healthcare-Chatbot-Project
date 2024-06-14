// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:healthcare_chatbot/main.dart';
import 'package:healthcare_chatbot/screens/login_page.dart';
import 'package:healthcare_chatbot/screens/register_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:healthcare_chatbot/services/local/cach_helper.dart';
import '../core/globals.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int langValue = language == 'en' ? 0 : 1;
  bool isExpanded = false;
  ExpansionTileController expansionController = ExpansionTileController();
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
            child: Center(
              child: Container(
                alignment: Alignment.center,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Container(
                        padding: EdgeInsets.only(left: 45),
                        height: 450,
                        child: Image.asset(
                          "images/Welcome-chatgpt robot.png",
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        AppLocalizations.of(context)!.welcome,
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.important_to_have,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RegisterScreen();
                          }));
                        },
                        child: Text(
                          AppLocalizations.of(context)!.create_account,
                          style:
                              TextStyle(color: Color(0xffFFE96D), fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff050522),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        },
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style:
                              TextStyle(color: Color(0xffFFE96D), fontSize: 20),
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
          Positioned(
            top: 70,
            left: 25,
            right: 25,
            child: ExpansionTile(
              controller: expansionController,
              backgroundColor: Color(0xff1D5879),
              collapsedShape: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(25),
              ),
              collapsedBackgroundColor: Color(0xff1D5879),
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              shape: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(25),
              ),
              title: Text(
                AppLocalizations.of(context)!.change_lang,
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              tilePadding: EdgeInsets.symmetric(horizontal: 10),
              leading: const Icon(
                Icons.language,
                color: Colors.white,
              ),
              children: [
                ListTile(
                  leading: Text(
                    'English',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  trailing: Radio(
                    value: 0,
                    fillColor: MaterialStateProperty.all(
                      Colors.white,
                    ),
                    groupValue:
                        langValue, // profileController.selectedLang.value,

                    onChanged: (value) async {
                      expansionController.collapse();
                      langValue = value!;
                      await CacheHelper.saveData(
                          key: 'lang', value: value == 0 ? 'en' : 'ar');
                      if (context.mounted) {
                        Healthcarechatbot.changeLanguage(context, value);
                      } //  Healthcarechatbot.changeLanguage(context, value!);
                      //  profileController.changeLang(value!);
                    },
                    //   activeColor: HexColor(AppTheme.primaryColorString!),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    "العربية",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  leading: Radio(
                    value: 1,
                    groupValue:
                        langValue, //profileController.selectedLang.value,

                    fillColor: MaterialStateProperty.all(
                      Colors.white,
                    ),
                    onChanged: (value) async {
                      expansionController.collapse();

                      langValue = value!;
                      await CacheHelper.saveData(
                          key: 'lang', value: value == 0 ? 'en' : 'ar');
                      if (context.mounted) {
                        Healthcarechatbot.changeLanguage(context, value);
                      } // profileController.changeLang(value!);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
