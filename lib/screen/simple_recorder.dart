library social_media_recorder;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_recorder/provider/sound_record_notifier.dart';
import 'package:social_media_recorder/widgets/lock_record.dart';
import 'package:social_media_recorder/widgets/show_counter.dart';
import 'package:social_media_recorder/widgets/show_mic_with_text.dart';
import 'package:social_media_recorder/widgets/sound_recorder_when_locked_design.dart';

class RecorderReplaysAndComments extends StatefulWidget {
  /// function reture the recording sound file
  final Function(File soundFile) sendRequestFunction;

  /// recording Icon That pressesd to start record
  final Widget? recordIcon;

  /// recording Icon when user locked the record
  final Widget? recordIconWhenLockedRecord;

  /// use to change the backGround Icon when user recording sound
  final Color? recordIconBackGroundColor;

  /// use to change the Icon backGround color when user locked the record
  final Color? recordIconWhenLockBackGroundColor;

  /// use to change all recording widget color
  final Color? backGroundColor;

  /// use to change the counter style
  final TextStyle? counterTextStyle;

  /// text to know user should drag in the left to cancel record
  final String? slideToCancelText;

  /// use to change slide to cancel textstyle
  final TextStyle? slideToCancelTextStyle;

  /// this text show when lock record and to tell user should press in this text to cancel recod
  final String? cancelText;

  /// use to change cancel text style
  final TextStyle? cancelTextStyle;

  /// put you file directory storage path if you didn't pass it take deafult path
  final String? storeSoundRecoringPath;
  RecorderReplaysAndComments({
    this.storeSoundRecoringPath = "",
    required this.sendRequestFunction,
    this.recordIcon,
    this.recordIconWhenLockedRecord,
    this.recordIconBackGroundColor = Colors.blue,
    this.recordIconWhenLockBackGroundColor = Colors.blue,
    this.backGroundColor,
    this.cancelTextStyle,
    this.counterTextStyle,
    this.slideToCancelTextStyle,
    this.slideToCancelText = " Slide to Cancel >",
    this.cancelText = "Cancel",
  });

  @override
  _SimpleRecorderState createState() => _SimpleRecorderState();
}

class _SimpleRecorderState extends State<RecorderReplaysAndComments> {
  late SoundRecordNotifier soundRecordNotifier;

  @override
  void initState() {
    soundRecordNotifier = SoundRecordNotifier();
    soundRecordNotifier.initialStorePathRecord =
        widget.storeSoundRecoringPath ?? "";
    soundRecordNotifier.isShow = false;
    soundRecordNotifier.voidInitialSound();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => soundRecordNotifier),
        ],
        child: Consumer<SoundRecordNotifier>(
          builder: (context, value, _) {
            return Directionality(
                textDirection: TextDirection.rtl, child: makeBody(value));
          },
        ));
  }

  Widget makeBody(SoundRecordNotifier state) {
    return Column(
      children: [
        GestureDetector(
          onHorizontalDragUpdate: (scrollEnd) {
            state.updateScrollValue(scrollEnd.globalPosition, context);
          },
          onHorizontalDragEnd: (x) {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: recordVoice(state),
          ),
        )
      ],
    );
  }

  Widget recordVoice(SoundRecordNotifier state) {
    if (state.lockScreenRecord == true) {
      return SoundRecorderWhenLockedDesign(
        cancelText: widget.cancelText,
        cancelTextStyle: widget.cancelTextStyle,
        recordIconWhenLockBackGroundColor:
            widget.recordIconWhenLockBackGroundColor ?? Colors.blue,
        counterTextStyle: widget.counterTextStyle,
        recordIconWhenLockedRecord: widget.recordIconWhenLockedRecord,
        sendRequestFunction: widget.sendRequestFunction,
        soundRecordNotifier: state,
      );
    }

    return Listener(
      onPointerDown: (details) async {
        state.setNewInitialDraggableHeight(details.position.dy);
        state.resetEdgePadding();

        soundRecordNotifier.isShow = true;
        state.record();
      },
      onPointerUp: (details) async {
        if (!state.isLocked) {
          // soundRecordNotifier.isShow = false;
          if (state.buttonPressed) {
            if (state.second > 1 || state.minute > 0) {
              String path = state.mPath;
              await Future.delayed(Duration(milliseconds: 500));
              widget.sendRequestFunction(File.fromUri(Uri(path: path)));
            }
          }
          state.resetEdgePadding();
        }
      },
      child: Container(
          width: (soundRecordNotifier.isShow)
              ? MediaQuery.of(context).size.width
              : 50,
          child: Stack(
            children: [
              AnimatedPadding(
                duration: Duration(milliseconds: state.edge == 0 ? 700 : 0),
                curve: Curves.easeIn,
                padding: EdgeInsets.only(right: state.edge * 0.8),
                child: Container(
                  color: widget.backGroundColor ?? Colors.grey.shade100,
                  child: Stack(
                    children: [
                      ShowMicWithText(
                        backGroundColor: widget.recordIconBackGroundColor,
                        recordIcon: widget.recordIcon,
                        shouldShowText: soundRecordNotifier.isShow,
                        soundRecorderState: state,
                        slideToCancelTextStyle: widget.slideToCancelTextStyle,
                        slideToCancelText: widget.slideToCancelText,
                      ),
                      if (soundRecordNotifier.isShow)
                        ShowCounter(soundRecorderState: state),
                    ],
                  ),
                ),
              ),
              Container(width: 60, child: LockRecord(soundRecorderState: state))
            ],
          )),
    );
  }
}
