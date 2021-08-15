import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:game/loop_isolate/loop_isolate.dart';
import 'package:game/models/bubble.dart';
import 'package:game/models/planet.dart';
import 'package:game/models/player.dart';
import 'package:game/models/screen_object.dart';
import 'package:get/get.dart';
import 'package:game/utils/my_logger.dart';

class GameController extends GetxController {
  // создаем порт, на котором будем принимать сообщения от изолята
  ReceivePort _receivePort = ReceivePort();
  late SendPort _isolateSendPort;
  late final Isolate _isolateLoop;
  double startTapGlobalPositionX = 0;
  double startTapGlobalPositionY = 0;
  bool isGamePaused = false;


  RxInt _score = 0.obs;
    int get score => _score.value;

  List<ScreenObject> screenObjects = <ScreenObject>[];

  List<Widget> get screenWidgets =>
      screenObjects.map((sObject) => sObject.build()).toList();
  Player player = Player(Size(800,600));

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
    // Создаем слушатель в котором получаем тики от изолята
    _receivePort.listen((message) {
      if (message is bool) {
        _score.value++;
        updateObjects();
      }
      // print("Основной поток получил $message");
      if (message is SendPort) {
        _isolateSendPort = message;
        _isolateSendPort.send(true);
      }
    });
  }

  void createGameObject(int count) {
    screenObjects = [];
    for (var i = 0; i < count; i++) {
      var planet = Planet(_windowSize);
      screenObjects.add(planet);
    }
    screenObjects.add(player);
  }

  void updateObjects(){
    screenObjects.forEach((sObject) {
      sObject.move();
    });
  }

  Size _windowSize = Size(800,600);
  setWindowsSize(Size size) {
    _windowSize = size;
    player = Player(_windowSize);
    createGameObject(30);
  }

  // --------- Обработчики нажатий на экран -----------------

  void onPanStart(DragStartDetails details) {
    startTapGlobalPositionX = details.globalPosition.dx;
    startTapGlobalPositionY = details.globalPosition.dy;
  }

  void onPanUpdate(DragUpdateDetails details) {
    double updateGlobalPositionX = details.globalPosition.dx;
    double updateGlobalPositionY = details.globalPosition.dy;
    double deadZone = 5;

    if (updateGlobalPositionX > startTapGlobalPositionX + deadZone) {
      player.isMoveRight = true;
    } else {
      player.isMoveRight = false;
    }

    if (updateGlobalPositionX < startTapGlobalPositionX - deadZone) {
      player.isMoveLeft = true;
    } else {
      player.isMoveLeft = false;
    }

    if (updateGlobalPositionY > startTapGlobalPositionY + deadZone) {
      player.isMoveDown = true;
    } else {
      player.isMoveDown = false;
    }

    if (updateGlobalPositionY < startTapGlobalPositionY - deadZone) {
      player.isMoveUp = true;
    } else {
      player.isMoveUp = false;
    }
  }

  void onPanCancel(DragEndDetails details) {
    player.isMoveRight = false;
    player.isMoveLeft = false;
    player.isMoveUp = false;
    player.isMoveDown = false;
  }

  void onPauseTap() {
    // _isolateSendPort.send(isGamePaused);
    isGamePaused = !isGamePaused;

  }


  stopLoop() {

  }

  @override
  void onClose() {
    logPrint("GameController onClose");
    stopLoop();
    super.onClose();
  }
}