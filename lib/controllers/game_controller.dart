import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:game/loop_isolate.dart';
import 'package:game/models/bubble.dart';
import 'package:get/get.dart';
import 'package:game/utils/my_logger.dart';

class GameController extends GetxController {
  late ReceivePort _receivePort;
  late Isolate _isolateLoop;
  RxDouble _x = 0.0.obs;
  double get x => _x.value;
  List<Bubble> bubbles = <Bubble>[];

  @override
  void onInit() {
    logPrint("GameController onInit");
    super.onInit();
    for (var i = 0; i < 10; i++) {
      var bubble = Bubble(_windowSize);
      bubbles.add(bubble);
    }
    startIsolateLoop();
  }

  /// Запускаем изолят, который шлет сообщения о необходимости обновы экрана (тики)
  void startIsolateLoop() async {
    // создаем порт, на котором будем принимать сообщения от изолята
    _receivePort = ReceivePort();
    // создаем сам изолят, передаем в него статическую функцию (выполняемую в изоляте) и ее единственный параметр - порт на который она будет отправлять сообщения
    _isolateLoop = await Isolate.spawn(loopIsolate, _receivePort.sendPort);
    _receivePort.listen((message) {
      _x.value++;
      moveBubbles();
    });
  }

  void moveBubbles(){
    bubbles.forEach((bubble) {
      bubble.move();
    });
  }

  Size _windowSize = Size(800,600);
  setWindowsSize(Size size) {
    _windowSize = size;
  }

  someMethod() {
    print("some");
  }

  continueIsolateLoop() {

  }

  @override
  void onClose() {
    logPrint("GameController onClose");
    stopLoop();
    super.onClose();
  }
}