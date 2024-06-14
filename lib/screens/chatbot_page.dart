//ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_import, override_on_non_overriding_member, annotate_overrides, prefer_final_fields, unused_field, prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:healthcare_chatbot/services/local/cach_helper.dart';
import 'package:healthcare_chatbot/models/Precautions.dart';
import 'package:healthcare_chatbot/main.dart';
import 'package:healthcare_chatbot/models/message.dart';
import 'package:healthcare_chatbot/screens/Map.dart';
import 'package:healthcare_chatbot/screens/aboutUs_page.dart';
import 'package:healthcare_chatbot/screens/contactUs_page.dart';
import 'package:healthcare_chatbot/screens/login_page.dart';
import 'package:healthcare_chatbot/widget/chatbot_bubble.dart';
import 'package:healthcare_chatbot/widget/patient_bubble.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:record/record.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:healthcare_chatbot/core/globals.dart';
import 'package:speech_to_text/speech_to_text.dart';

List<Map<String, dynamic>> messages = [];
List<Map<String, String>> supportedLocales = [
  {"name": "English", "localeId": "en_US"},
  {"name": "Arabic", "localeId": "ar_AR"},
];

late Map<String, String> selectedLocale;

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  List<Message> messageList = [];
  CollectionReference message =
      FirebaseFirestore.instance.collection('message');
  int langValue = language == 'en' ? 0 : 1;
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();
  var response;
  TextEditingController _textFieldController = TextEditingController();
  String _responseText = '';
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  AudioRecorder auido = AudioRecorder();
//////////////////////////////////////////////////

  Future<void> _sendRequest(String text) async {
    String url = 'https://final-rate.onrender.com/predict';
    try {
      Map<String, String> requestBody = {'text': text};
      String jsonData = jsonEncode(requestBody);

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        // Extract the value of the "predicted" key from the JSON response
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String predictedDisease = responseData['predicted'];

        setState(() {
          _responseText = predictedDisease;
        });
      } else if (response.statusCode == 400) {
        // Extract the error message from the JSON response
        Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage = errorData['error'];

        setState(() {
          _responseText = errorMessage;
        });
      } else {
        throw Exception('Failed to load response');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  String userName = '';
  String userEmail = '';
  String? value;

  getName() async {
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    String firstName = userData['firstName'];
    String email = userData['email'];
    userName = firstName;
    userEmail = email;
    setState(() {});
  }

/////////////////////////////////////////////////////////////////
  // This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: selectedLocale['localeId'],
    );
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
    if (_lastWords.isNotEmpty) {
      message.add({
        "message": _lastWords,
        "createdAt": DateTime.now(),
        "id": userEmail,
      });
      await _sendRequest(_lastWords);

      if (_responseText.isNotEmpty) {
        message.add({
          "message": _responseText,
          "createdAt": DateTime.now(),
          "id": 'bot',
        });
        setState(() {});
      }
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

//////////////////////////////////////////////////////////////////
  @override
  initLang() async {
    selectedLocale = await CacheHelper.getData(
              key: 'lang',
            ) ==
            'en'
        ? supportedLocales[0]
        : supportedLocales[1];
  }

  @override
  void dispose() {
    super.dispose(); // Always call super.dispose() at the end.
  }

  initWelcome() async {
    await message.add({
      "message": AppLocalizations.of(context)!.dialog_message,
      "createdAt": DateTime.now(),
      "id": 'bot',
    });
    setState(() {});
  }

  void initState() {
    initWelcome();
    initLang();
    super.initState();
    _initSpeech();
    FirebaseAuth.instance.authStateChanges().listen((User? user) async{
      if (user == null) {
        // User is signed out
        print('User is signed out');
         clearAllMessages();
         initWelcome();
      } else {
        // User is signed in
        print('User is signed in');
        getName();
        await clearAllMessages();
        await initWelcome();
      }
    });
  }

  Future<void> clearAllMessages() async {
    QuerySnapshot allMessagesSnapshot = await message.get();
    for (DocumentSnapshot doc in allMessagesSnapshot.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: message.orderBy('createdAt').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Color(0xff071C29),
              leading: Padding(
                padding: const EdgeInsets.only(left: 10, right: 15),
                child: Image.asset(
                  "images/blue-robot-mascot-logo-icon-design_675467-55 1 (Traced) (1).png",
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 30, right: 20),
                child: Text(
                  AppLocalizations.of(context)!.healthcaretitle,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            endDrawer: Drawer(
              child: ListView(
                controller: _controller,
                padding: EdgeInsets.symmetric(),
                children: [
                  UserAccountsDrawerHeader(
                    currentAccountPictureSize: Size(70, 70),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage('images/profile.png'),
                      backgroundColor: Colors.white,
                    ),
                    accountName: Row(
                      children: [
                        Text(
                          "$userName ",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    accountEmail: Text(
                      userEmail,
                      style: TextStyle(fontSize: 20),
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 65, 111, 149),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  /////////////////////////////////////////////////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: ExpansionTile(
                      shape: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.change_lang,
                        style: TextStyle(fontSize: 22),
                      ),
                      tilePadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.language,
                        size: 30,
                      ),
                      children: [
                        ListTile(
                          leading: Text(
                            'English',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          trailing: Radio(
                            value: 0, //Languages.english,
                            groupValue:
                                langValue, // profileController.selectedLang.value,
                            onChanged: (value) async {
                              langValue = value!;
                              await CacheHelper.saveData(
                                  key: 'lang', value: value == 0 ? 'en' : 'ar');
                              if (context.mounted) {
                                Healthcarechatbot.changeLanguage(
                                    context, value);
                              } //  Healthcarechatbot.changeLanguage(context, value!);
                              //  profileController.changeLang(value!);
                              await initLang();
                              setState(() {});
                            },
                            //   activeColor: HexColor(AppTheme.primaryColorString!),
                          ),
                        ),
                        ListTile(
                          trailing: Text(
                            "العربية",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          leading: Radio(
                            value: 1,
                            groupValue:
                                langValue, //profileController.selectedLang.value,
                            onChanged: (value) async {
                              langValue = value!;
                              await CacheHelper.saveData(
                                  key: 'lang', value: value == 0 ? 'en' : 'ar');
                              if (context.mounted) {
                                Healthcarechatbot.changeLanguage(
                                    context, value);
                              }
                              await initLang();
                              setState(() {});

                              // profileController.changeLang(value!);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  /////////////////////////////////////////////////////////
                  ListTile(
                    leading: Icon(
                      Icons.location_on,
                      size: 30,
                    ),
                    title: Text(
                        AppLocalizations.of(context)!.find_the_closest_hospital,
                        // "find_the_closest_hospital",
                        style: TextStyle(fontSize: 22)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Mappage();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.chat,
                      size: 30,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.new_chat,
                      style: TextStyle(fontSize: 22),
                    ),
                    onTap: () async {
                      await clearAllMessages();
                      await initWelcome();
                      setState(() {});

                      Navigator.pop(context);
                    },
                  ),

                  ListTile(
                    leading: Icon(
                      Icons.question_answer_rounded,
                      size: 30,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.contact_us,
                      style: TextStyle(fontSize: 22),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ContactUsPage();
                      }));
                    },
                  ),

                  ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      size: 30,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.about_us,
                      style: TextStyle(fontSize: 22),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AboutUsPage();
                      }));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 0),
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                        size: 30,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.logout,
                        style: TextStyle(fontSize: 22),
                      ),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
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
                    Expanded(
                      child: ListView.builder(
                        controller: _controller,
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return messageList[index].id == userEmail
                              ? PatientBublle(
                                  message: messageList[index],
                                )
                              : ChatBubleBot(
                                  fun: () {
                                    if (precautions
                                        .containsKey(_responseText)) {
                                      message.add({
                                        "message": precautions[_responseText],
                                        "createdAt": DateTime.now(),
                                        "id": 'bot',
                                      });
                                    }
                                    _responseText = '';
                                  },
                                  load: _responseText,
                                  message: messageList[index],
                                );
                        },
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            height: 75,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: TextField(
                                      controller: controller,
                                      onSubmitted: (data) async {
                                        if (data.isNotEmpty) {
                                          value = data;
                                          message.add({
                                            "message": data,
                                            "createdAt": DateTime.now(),
                                            "id": userEmail,
                                          });
                                          controller.clear();
                                          _controller.animateTo(
                                            _controller
                                                .position.maxScrollExtent,
                                            duration: Duration(seconds: 1),
                                            curve: Curves.fastOutSlowIn,
                                          );

                                          await _sendRequest(data);

                                          if (_responseText.isNotEmpty) {
                                            message.add({
                                              "message": _responseText,
                                              "createdAt": DateTime.now(),
                                              "id": 'bot',
                                            });
                                            response = _responseText;
                                            setState(() {});
                                          }
                                        }
                                      },
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        fillColor: Color(0xff050423),
                                        filled: true,
                                        hintText: AppLocalizations.of(context)!
                                            .message_me,
                                        counterStyle: TextStyle(),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.send,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () async {
                                            String data = controller.text;
                                            if (data.isNotEmpty) {
                                              message.add({
                                                "message": data,
                                                "createdAt": DateTime.now(),
                                                "id": userEmail,
                                              });
                                              controller.clear();
                                              _controller.animateTo(
                                                _controller
                                                    .position.maxScrollExtent,
                                                duration: Duration(seconds: 1),
                                                curve: Curves.fastOutSlowIn,
                                              );

                                              await _sendRequest(data);

                                              if (_responseText.isNotEmpty) {
                                                message.add({
                                                  "message": _responseText,
                                                  "createdAt": DateTime.now(),
                                                  "id": 'bot',
                                                });
                                              }
                                            }
                                          },
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: 35, top: 40, right: 35),
                                        hintStyle:
                                            TextStyle(color: Color(0xffE4C661)),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 4, left: 4),
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xff050423),
                                    radius: 27,
                                    child: IconButton(
                                        icon: Icon(
                                          _speechToText.isNotListening
                                              ? Icons.mic_off
                                              : Icons.mic,
                                          color: Colors.blue,
                                        ),
                                        onPressed: _speechToText.isNotListening
                                            ? _startListening
                                            : _stopListening),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
