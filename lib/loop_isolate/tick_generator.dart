import 'dart:async';
import 'dart:isolate';

import 'package:game/utils/my_logger.dart';

class TickGenerator {
  late SendPort sendPort;

  final double _fps = 50;
  final double _oneSecond = 1000; //in ms
  double _updateTime = 20; // time in ms to update screen
  bool _isLoopRunning = true;

  // таймер
  Stopwatch _loopWatch = Stopwatch();

  TickGenerator(this.sendPort) {
    // set time in ms to update screen
    _updateTime = _oneSecond / _fps;
  }

  void startGenerate() async {
    print("tickGenerator start");
    _loopWatch.start();
    _isLoopRunning = true;

    double _updates = 0;
    Stopwatch _fpsCounter = Stopwatch();
    _fpsCounter.start();

    while (_isLoopRunning) {
      if (_loopWatch.elapsedMilliseconds >= _updateTime) {
        _loopWatch.reset();
        // отправляем что-то (например true) в порт
        sendPort.send(true);
        // необходима такая задержка, чтобы цикл не весил поток наглухо
        await Future.delayed(Duration(milliseconds: 1));

        _updates++;
        if (_fpsCounter.elapsedMilliseconds >= _oneSecond) {
          logPrint("loopIsolate - $_updates");
          _updates = 0;
          _fpsCounter.reset();
        }
      }
    }
    _loopWatch.stop();
    // print("stopLoop $_isLoopRunning - LOOP END");
  }

  void stopGenerate() {
    print("tickGenerator stop");
    _isLoopRunning = false;
  }

}
