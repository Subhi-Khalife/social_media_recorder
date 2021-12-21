import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_recorder/presentation/new_work/provider/sound_record_notifier.dart';
import 'package:social_media_recorder/presentation/new_work/screen/simple_recorder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SoundRecordNotifier(currentPlace: Offset(0, 0)),
        ),
      ],
      child: MaterialApp(
        home: MyHomePage(),
      ),
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
                /// soundFile The sound return When Finish record sound
              },
              
            ),
          ),
        ),
      ),
    );
  }
}
