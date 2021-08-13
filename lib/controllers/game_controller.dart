import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:game/loop_isolate.dart';
import 'package:game/models/bubble.dart';
import 'package:game/models/screen_object.dart';
import 'package:get/get.dart';
import 'package:game/utils/my_logger.dart';

class GameController extends GetxController {
  // создаем порт, на котором будем принимать сообщения от изолята
  ReceivePort _receivePort = ReceivePort();

  late final Isolate _isolateLoop;

  RxInt _score = 0.obs;
    int get score => _score.value;

  List<ScreenObject> screenObjects = <ScreenObject>[];

  @override
  void onInit() {
    logPrint("GameController onInit");
    super.onInit();
    startIsolateLoop();
  }

  /// Запускаем изолят, который шлет сообщения о необходимости обновы экрана (тики)
  void startIsolateLoop() async {
    // создаем сам изолят, передаем в него статическую функцию (выполняемую в изоляте) и ее единственный параметр - порт на который она будет отправлять сообщения
    _isolateLoop = await Isolate.spawn(loopIsolate, _receivePort.sendPort);
    _receivePort.listen((message) {
      _score.value++;
      updateObjects();
    });
  }

  void createGameObject(int count) {
    screenObjects = [];
    for (var i = 0; i < count; i++) {
      var bubble = Bubble(_windowSize);
      screenObjects.add(bubble);
    }
  }

  void updateObjects(){
    screenObjects.forEach((sObject) {
      sObject.move();
    });
  }

  Size _windowSize = Size(800,600);
  setWindowsSize(Size size) {
    _windowSize = size;
    createGameObject(30);
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