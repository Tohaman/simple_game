import 'dart:isolate';

import 'package:flutter/material.dart';

import 'utils/my_logger.dart';

bool _isLoopRunning = true;

loopIsolate(SendPort sendPort){
  final double _fps = 60;
  final double _oneSecond = 1000; //in ms
  final double _updateTime = _oneSecond / _fps; // time in ms to update screen
  _isLoopRunning = true;

  Stopwatch _loopWatch = Stopwatch();
  _loopWatch.start();

  // double _updates = 0;
  // Stopwatch _fpsCounter = Stopwatch();
  // _fpsCounter.start();

  while (_isLoopRunning) {
    if (_loopWatch.elapsedMilliseconds >= _updateTime) {
      _loopWatch.reset();
      // отправляем что-то (например true) в порт
      sendPort.send(true);

      // _updates++;
      // if (_fpsCounter.elapsedMilliseconds >= _oneSecond) {
      //   logPrint("loopIsolate - $_updates");
      //   _updates = 0;
      //   _fpsCounter.reset();
      // }
    }
  }
}



void stopLoop() {
  _isLoopRunning = false;
}
