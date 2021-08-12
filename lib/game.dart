import 'package:flutter/material.dart';
import 'package:game/controllers/game_controller.dart';
import 'package:get/get.dart';

class Game extends GetView<GameController> {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.setWindowsSize(MediaQuery.of(context).size);
    return Scaffold(
      body: Obx(() {
        print(controller.x);
        return Stack(
          children:
          controller.bubbles.map((bubble) =>
              Positioned(
                  top: bubble.y,
                  left: bubble.x,
                  child: Text("O")
              )
          ).toList()
        );
      }),
    );
  }
}
