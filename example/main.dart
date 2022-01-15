import 'package:flutter/material.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/provider/sound_record_notifier.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // The line below forces the theme to iOS.
        platform: TargetPlatform.iOS,
      ),
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
            child: SocialMediaRecorder(
              sendRequestFunction: (soundFile) {
                print("the current path is ${soundFile.path}");
              },
              encode: AudioEncoderType.AAC,
            ),
          ),
        ),
      ),
    );
  }
}
