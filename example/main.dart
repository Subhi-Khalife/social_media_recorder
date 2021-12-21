import 'package:flutter/material.dart';
import 'package:social_media_recorder/screen/simple_recorder.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          child: Align(
            alignment: Alignment.centerRight,
            child: RecorderReplaysAndComments(
              sendRequestFunction: (soundFile) {
                /// soundFile => record sound file
                print("the current path is ${soundFile.path}");
              },
            ),
          ),
        ),
      ),
    );
  }
}
