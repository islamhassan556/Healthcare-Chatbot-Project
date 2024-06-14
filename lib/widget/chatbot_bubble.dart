// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:healthcare_chatbot/models/Precautions.dart';
import 'package:healthcare_chatbot/models/message.dart';

class ChatBubleBot extends StatelessWidget {
  final Message message;
  final String load;

  final VoidCallback fun;
  const ChatBubleBot({
    Key? key,
    required this.message,
    required this.fun,
    required this.load,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FlutterTts flutterTts = FlutterTts();

    Future<void> _speak(String text) async {
      await flutterTts.setLanguage('en-US');
      await flutterTts.speak(text);
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Row(
            children: [
              Image.asset("images/Icon-chatbot.png", height: 60),
              Padding(padding: EdgeInsets.only(left: 2)),
              Flexible(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  padding:
                      EdgeInsets.only(left: 16, top: 25, bottom: 25, right: 16),
                  decoration: BoxDecoration(
                    color: Color(0xff24415C),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32),
                    ),
                  ),
                  child: Text(
                    message.message,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 75, right: 85),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.volume_up),
                  color: Colors.blue,
                  iconSize: 30,
                  onPressed: () {
                    _speak(message.message); // Call TTS function
                  },
                ),
                SizedBox(width: 10),
                IconButton(
                    onPressed: fun,
                    icon: precautions.containsKey(load)
                        ? Icon(
                            Icons.menu_book,
                            color: Colors.blue,
                            size: 28,
                          )
                        : SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
