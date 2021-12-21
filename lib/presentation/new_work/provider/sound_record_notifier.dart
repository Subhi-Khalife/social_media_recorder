import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:uuid/uuid.dart';

class SoundRecordNotifier extends ChangeNotifier {
  Timer? _timer;
  Timer? _timerCounter;
  double hightPosition = 0;
  double last = 0;
  String _sdPath = "";
  String initialStorePathRecord = "";
  String storagePath = "";
  RecordMp3 recordMp3 = RecordMp3.instance;
  bool _isAcceptedPermission = false;
  double currentButtonHeihtPlace = 0;
  bool isLocked = false;
  bool isShow = false;
  ////////////////////////////////////////
  late int second;
  late int minute;
  late bool buttonPressed;
  late double edge;
  late bool loopActive;
  late String mPath;
  late bool mPlayerIsInited;
  late bool mRecorderIsInited;
  late bool mplaybackReady;
  late bool startRecord;
  late Offset currentPlace;
  late double heightPosition;
  late double lockScreenIconPlace;
  late bool lockScreenRecord;
  SoundRecordNotifier({
    this.edge = 0.0,
    this.minute = 0,
    this.second = 0,
    this.buttonPressed = false,
    required this.currentPlace,
    this.loopActive = false,
    this.mPath = '',
    this.mPlayerIsInited = false,
    this.mplaybackReady = false,
    this.mRecorderIsInited = false,
    this.startRecord = false,
    this.heightPosition = 0,
    this.lockScreenRecord = false,
    this.lockScreenIconPlace = 0,
  });

  void _mapCounterGenerater() {
    _timerCounter = Timer(Duration(seconds: 1), () {
      _increaseCounterWhilePressed();
      _mapCounterGenerater();
    });
  }

  resetEdgePadding() async {
    isLocked = false;
    edge = 0;
    buttonPressed = false;
    second = 0;
    minute = 0;
    isShow = false;
    heightPosition = 0;
    lockScreenIconPlace = 0;
    lockScreenRecord = false;
    if (_timer != null) _timer!.cancel();
    if (_timerCounter != null) _timerCounter!.cancel();
    recordMp3.stop();
    recordMp3.status;
    notifyListeners();
  }

  Future<String> getFilePath() async {
    _sdPath = initialStorePathRecord.length == 0 ? "/storage/emulated/0/new_record_sound" : mPath;
    var d = Directory(_sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    var uuid = Uuid();
    String uid = uuid.v1();
    storagePath = _sdPath + "/" + uid + ".mp3";
    mPath = storagePath;
    return storagePath;
  }

  setNewInitialDraggableHeight(double newValue) {
    currentButtonHeihtPlace = newValue;
  }

  updateScrollValue(Offset currentValue, BuildContext context) async {
    final x = currentValue;
    double hightValue = currentButtonHeihtPlace - x.dy;
    if (hightValue >= 50) {
      isLocked = true;
      lockScreenRecord = true;
      hightValue = 50;
      notifyListeners();
    }
    if (hightValue < 0) hightValue = 0;
    heightPosition = hightValue;
    lockScreenRecord = isLocked;
    notifyListeners();
    if (x.dx <= MediaQuery.of(context).size.width * 0.77) {
      resetEdgePadding();
    } else if (x.dx >= MediaQuery.of(context).size.width) {
      edge = 0;
      edge = 0;
    } else {
      if (x.dx <= MediaQuery.of(context).size.width * 0.5) {}
      if (last < x.dx) {
        edge = edge -= x.dx / 200;
        if (edge < 0) {
          edge = 0;
        }
      } else if (last > x.dx) {
        edge = edge += x.dx / 200;
      }
      last = x.dx;
    }
    notifyListeners();
  }

  _increaseCounterWhilePressed() {
    if (loopActive) {
      return;
    }

    loopActive = true;

    second = second + 1;
    buttonPressed = buttonPressed;
    if (second == 60) {
      second = 0;
      minute = minute + 1;
    }

    notifyListeners();
    loopActive = false;
    notifyListeners();
  }

  record() async {
    if (!_isAcceptedPermission) {
      await Permission.microphone.request();
      await Permission.manageExternalStorage.request();
      await Permission.storage.request();
      _isAcceptedPermission = true;
    } else {
      buttonPressed = true;
      String recordFilePath = await getFilePath();
      _timer = Timer(Duration(milliseconds: 900), () {
        recordMp3.start(recordFilePath, (type) {});
      });
      _mapCounterGenerater();
      notifyListeners();
    }
    notifyListeners();
  }

  voidInitialSound() async {
    startRecord = false;
    final status = await Permission.microphone.status;
    if (status.isGranted) {
      final result = await Permission.storage.request();
      if (result.isGranted) {
        _isAcceptedPermission = true;
      }
    }
  }
}
