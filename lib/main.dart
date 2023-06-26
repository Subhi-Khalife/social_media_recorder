import 'package:flutter/material.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double right = 32;
  double bottom = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            right: right,
            bottom: bottom,
            child: SocialMediaRecorder(
              onPointedDown: () {
                right = 0;
                bottom = 0;
                setState(() {});
              },
              onPointedUp: () {
                right = 32;
                bottom = 0;
                setState(() {});
              },
              recordIcon:
                  Icon(Icons.keyboard_voice_rounded, color: Colors.white),
              sendRequestFunction: (soundFile) {
                print("the current path is ${soundFile.path}");
              },
              encode: AudioEncoderType.AAC,
            ),
          ),
        ],
      ),
    );
  }
}
