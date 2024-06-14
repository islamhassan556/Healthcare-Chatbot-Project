
// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, avoid_print, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ConnectionPage());
}

class ConnectionPage extends StatelessWidget {
  const ConnectionPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textFieldController = TextEditingController();
  String _responseText = 'Please enter valid symptoms'; // Default response text

  Future<void> _sendRequest(String text) async {
    String url = ''; // Replace with your Flask server URL and endpoint
    try {
      // Create a JSON object with the input text
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
          _responseText = predictedDisease; // Set the predicted disease directly
        });
      } else if (response.statusCode == 400) {
        // Extract the error message from the JSON response
        Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage = errorData['error'];
        
        setState(() {
          _responseText = errorMessage; // Display the error message
        });
      } else {
        throw Exception('Failed to load response');
      }
   
  
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _textFieldController,
              decoration: InputDecoration(labelText: 'Enter Text'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _sendRequest(_textFieldController.text);
              },
              child: Text('Send Request'),
            ),
            SizedBox(height: 20),
            // Display the response text (predicted disease or error message) from the Flask server
            Text(
              _responseText,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}


