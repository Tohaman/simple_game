import 'dart:isolate';

import 'package:game/loop_isolate/tick_generator.dart';

bool _isLoopRunning = true;

loopIsolate(SendPort sendPort){
  final double _fps = 50;
  final double _oneSecond = 1000; //in ms
  final double _updateTime = _oneSecond / _fps; // time in ms to update screen
  _isLoopRunning = true;
  // Создаем порт слушатель уже внутри изолята
  ReceivePort receivePort = ReceivePort();
  // Отправляем данные в основной изолят, о том, куда присылать данные в этот изолят
  sendPort.send(receivePort.sendPort);

  TickGenerator tickGenerator = TickGenerator(sendPort);

  // И создаем слушатель тут, в который будут приходить данные из основного изолята
  receivePort.listen((message) {
    print("Изолят получил $message");
    if (message is bool) {
      _isLoopRunning = message;
      if (message) {
        tickGenerator.startGenerate();
      } else {
        tickGenerator.stopGenerate();
      }
      sendPort.send("big cycle end");
    }
  });

}


void stopLoop() {
  _isLoopRunning = false;
  print("stopLoop $_isLoopRunning");
}
