// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_import
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_chatbot/screens/onboarding_page2.dart';
import '../core/globals.dart';
import '../main.dart';
import '../services/local/cach_helper.dart';

class OnboardingPage1 extends StatefulWidget {
  const OnboardingPage1({super.key});

  @override
  State<OnboardingPage1> createState() => _OnboardingPage1State();
}

class _OnboardingPage1State extends State<OnboardingPage1> {
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
              // ignore: sized_box_for_whitespace
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
                      Icons.rectangle_rounded,
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
                height: 45,
              ),
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.onboard_1_1,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    AppLocalizations.of(context)!.onboard_1_2,
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return OnboardingPage2();
                    }));
                  },
                  child: Text(
                    //translation
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
                    value: 0 
                    ,
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
