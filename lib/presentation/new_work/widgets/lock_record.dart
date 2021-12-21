import 'package:flutter/material.dart';
import 'package:social_media_recorder/presentation/new_work/provider/sound_record_notifier.dart';

class LockRecord2 extends StatefulWidget {
  final SoundRecordNotifier soundRecorderState;
  const LockRecord2({required this.soundRecorderState});
  @override
  _LockRecordState createState() => _LockRecordState();
}

class _LockRecordState extends State<LockRecord2> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    if(!widget.soundRecorderState.buttonPressed)
    return Container();
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
