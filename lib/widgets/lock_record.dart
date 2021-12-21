library social_media_recorder;
import 'package:flutter/material.dart';
import 'package:social_media_recorder/provider/sound_record_notifier.dart';

/// This Class Represent Icons To swap top to lock recording
class LockRecord extends StatefulWidget {
  /// Object From Provider Notifier
  final SoundRecordNotifier soundRecorderState;
  const LockRecord({required this.soundRecorderState});
  @override
  _LockRecordState createState() => _LockRecordState();
}

class _LockRecordState extends State<LockRecord> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    /// If click the Button Then send show lock and un lock icon
    if (!widget.soundRecorderState.buttonPressed) return Container();
    return AnimatedPadding(
      duration: Duration(seconds: 1),
      padding: EdgeInsets.all(widget.soundRecorderState.second % 2 == 0 ? 0 : 8),
      child: Transform.translate(
          offset: Offset(0, -70),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              opacity: widget.soundRecorderState.edge >= 50 ? 0 : 1,
              child: Container(
                height: 50 - widget.soundRecorderState.heightPosition < 0
                    ? 0
                    : 50 - widget.soundRecorderState.heightPosition,
                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          opacity: widget.soundRecorderState.second % 2 != 0 ? 0 : 1,
                          child: Image.asset(
                            "assets/images/lock.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          opacity: widget.soundRecorderState.second % 2 == 0 ? 0 : 1,
                          child: Image.asset(
                            "assets/images/unlock.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
