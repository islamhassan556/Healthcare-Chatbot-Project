// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isVisible = true; // Variable to control visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IconButton Visibility'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: _isVisible, // Control visibility using this variable
              child: IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  // Do something when the IconButton is pressed
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Toggle visibility
                  _isVisible = !_isVisible;
                });
              },
              child: Text(_isVisible ? 'Hide IconButton' : 'Show IconButton'),
            ),
          ],
        ),
      ),
    );
  }
}
