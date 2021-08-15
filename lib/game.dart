import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/controllers/game_controller.dart';
import 'package:get/get.dart';

class Game extends GetView<GameController> {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.setWindowsSize(Get.size);
    var width = Get.size.width;
    var height = Get.size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background2.png"),
                fit: BoxFit.cover
            )
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: width / 2,
                height: height,
                child: GestureDetector(
                  onPanStart: controller.onPanStart,
                  onPanUpdate: controller.onPanUpdate,
                  onPanEnd: controller.onPanCancel,
                ),
              )
            ),
            Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: width / 2,
                  height: height / 2,
                  child: GestureDetector(
                    onTap: controller.onPauseTap,
                  ),
                )
            ),
            updatedWidgets(width, height),
          ],
        ),
      ),
    );
  }

  Widget updatedWidgets(double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: Obx(() =>
        Stack(
          children: controller.screenWidgets +
            <Widget>[
              Positioned(
                top: 10,
                left: 10,
                child: Text(
                  "${controller.score}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
        ),
      ),
    );
  }
}
