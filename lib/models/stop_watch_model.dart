// import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:labbit/pages/timer.dart';
import 'dart:async';

bool isStopPressed = true;
bool isResetPressed = true;
bool isStartPressed = true;
String timerButtonName = "PLAY";
String stopWatchTimeDisplay = '00:00:00';

// String timerButtonName_S = "STOP";

class StopWatchModel extends ChangeNotifier {
  var swatch = Stopwatch();

  final dul = const Duration(seconds: 1);

  startTimer() {
    return Timer(dul, keepRunning);
  }

  keepRunning() {
    if (swatch.isRunning) {
      startTimer();
    }

    stopWatchTimeDisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") +
        ':' +
        (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
        ':' +
        (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    notifyListeners();
  }

  startStopWatch() {
    isStopPressed = false;
    isStartPressed = true;
    swatch.start();
    startTimer();
    notifyListeners();
    timerButtonName = "STOP";
  }

  stopStopWatch() {
    isStopPressed = true;
    isResetPressed = false;
    swatch.stop();
    notifyListeners();
    timerButtonName = "PLAY";
    stopWatchTimeDisplay = stopWatchTimeDisplay;
  }

  resetStopWatch() {
    isResetPressed = true;
    isStartPressed = true;
    swatch.reset();
    stopWatchTimeDisplay = '00:00:00';
    notifyListeners();
  }
}
