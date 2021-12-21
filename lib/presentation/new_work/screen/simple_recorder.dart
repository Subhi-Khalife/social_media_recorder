import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_recorder/presentation/new_work/provider/sound_record_notifier.dart';
import 'package:social_media_recorder/presentation/new_work/widgets/lock_record.dart';
import 'package:social_media_recorder/presentation/new_work/widgets/show_counter.dart';
import 'package:social_media_recorder/presentation/new_work/widgets/show_mic_with_text.dart';
import 'package:social_media_recorder/presentation/new_work/widgets/sound_recorder_when_locked_design.dart';

class RecorderReplaysAndComments extends StatefulWidget {
  final Function(File soundFile) sendRequestFunction;
  final Widget? recordIcon;
  final Widget? sendRecordIcon;
  final Color? recordIconBackGroundColor;
  final Color? sendrRecordBackGroundColor;
  final Color? backGroundColor;
  final TextStyle? counterTextStyle;
  final String? slideToCancelText;
  final TextStyle? slideToCancelTextStyle;
  final String? cancelText;
  final TextStyle? cancelTextStyle;
  final String? storeSoundRecoringPath;
  RecorderReplaysAndComments({
    this.storeSoundRecoringPath = "",
    required this.sendRequestFunction,
    this.recordIcon,
    this.sendRecordIcon,
    this.recordIconBackGroundColor = Colors.blue,
    this.sendrRecordBackGroundColor = Colors.blue,
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
    soundRecordNotifier = Provider.of<SoundRecordNotifier>(context, listen: false);
    soundRecordNotifier.initialStorePathRecord = widget.storeSoundRecoringPath ?? "";
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
    return Consumer<SoundRecordNotifier>(
      builder: (context, value, _) {
        return Directionality(textDirection: TextDirection.rtl, child: makeBody(value));
      },
    );
    // Directionality(textDirection: TextDirection.rtl, child: makeBody(state));
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
        counterTextStyle: widget.counterTextStyle,
        sendRecordIcon: widget.sendRecordIcon,
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
          width: (soundRecordNotifier.isShow) ? MediaQuery.of(context).size.width : 50,
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
                      ShowMicWithText2(
                        recordIcon: widget.recordIcon,
                        shouldShowText: soundRecordNotifier.isShow,
                        soundRecorderState: state,
                        slideToCancelTextStyle: widget.slideToCancelTextStyle,
                        slideToCancelText: widget.slideToCancelText,
                      ),
                      if (soundRecordNotifier.isShow) ShowCounter(soundRecorderState: state),
                    ],
                  ),
                ),
              ),
              Container(width: 60, child: LockRecord2(soundRecorderState: state))
            ],
          )),
    );
  }
}
