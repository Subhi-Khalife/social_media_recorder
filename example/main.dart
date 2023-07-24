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
  bool rec = false;
  String time = "0:00";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 400,
          ),
          rec ? const Text("Recording") : const Text("Not recording"),
          Text("Time:" + time),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 140, left: 4, right: 4),
              child: Align(
                alignment: Alignment.centerRight,
                child: SocialMediaRecorder(
                  startRecording: () {
                    setState(() {
                      rec = true;
                    });
                  },
                  stopRecording: (_time) {
                    setState(() {
                      rec = false;
                      time = _time;
                    });
                    print("stopped");
                    print(time);
                  },
                  sendRequestFunction: (soundFile, _time) {
                    // print("the current path is ${soundFile.path}");
                  },
                  encode: AudioEncoderType.AAC,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
