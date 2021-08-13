import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/controllers/game_controller.dart';
import 'package:get/get.dart';

class Game extends GetView<GameController> {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.setWindowsSize(MediaQuery.of(context).size);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Obx(() =>
          Stack(
            children: <Widget>[
              Text("${controller.score}")
            ] + controller.screenObjects
                .map((sObject) =>
                sObject.build()
            ).toList(),
          ),
        ),
      ),
    );
  }
}
