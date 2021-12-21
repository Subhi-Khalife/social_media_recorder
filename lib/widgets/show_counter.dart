import 'package:flutter/material.dart';
import 'package:social_media_recorder/provider/sound_record_notifier.dart';

/// Used this class to show counter and mic Icon
class ShowCounter extends StatelessWidget {
  final SoundRecordNotifier soundRecorderState;
  final TextStyle? counterTextStyle;
  ShowCounter({required this.soundRecorderState, this.counterTextStyle});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.4,
        color: Colors.grey.shade100,
        child: Padding(
          padding: EdgeInsets.only(top: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    soundRecorderState.second.toString().padLeft(2, '0'),
                    style: counterTextStyle ?? TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: 3),
                  Text(" : "),
                  Text(
                    soundRecorderState.minute.toString().padLeft(2, '0'),
                    style: counterTextStyle ?? TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(width: 3),
              AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: soundRecorderState.second % 2 == 0 ? 1 : 0,
                child: Container(
                  child: Icon(
                    Icons.mic,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
