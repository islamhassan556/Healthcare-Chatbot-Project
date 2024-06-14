// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:healthcare_chatbot/core/globals.dart';
import 'package:healthcare_chatbot/screens/register_page.dart';
import 'package:healthcare_chatbot/screens/splash_page.dart';
import 'firebase_options.dart';
import 'services/local/cach_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();

  language = await CacheHelper.getData(key: 'lang') ?? 'en';

  runApp(const Healthcarechatbot());
}

class Healthcarechatbot extends StatefulWidget {
  const Healthcarechatbot({super.key});

  @override
  State<Healthcarechatbot> createState() => _HealthcarechatbotState();

  static changeLanguage(BuildContext context, int val) async {
    final _HealthcarechatbotState? state =
        context.findAncestorStateOfType<_HealthcarechatbotState>();

    state!.changeLang(val);
  }
}

class _HealthcarechatbotState extends State<Healthcarechatbot> {
  changeLang(int val) {
    setState(() {
      language = val == 0 ? 'en' : 'ar';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          'registerPage': (context) => RegisterScreen(),
        },
        locale: Locale(language),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white, // Change the color here
            ),
          ),
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SplashPage();
            } else {
              return SplashPage();
            }
          },
        ));
  }
}
