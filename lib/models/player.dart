import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game/models/screen_object.dart';

class Player extends ScreenObject {
  double playerSize = 50;
  bool isMoveRight = false;
  bool isMoveLeft = false;
  bool isMoveUp = false;
  bool isMoveDown = false;
  double speed = 1;
  late Size _windowSize;

  Player(this._windowSize){
    x = 50;
    y = 200;
  }

  @override
  Widget build() {
    return Positioned(
        top: y,
        left: x,
        child: Transform.rotate(
            angle: pi / 2,
            child: Image.asset("assets/player3.png", height: playerSize)
        )
    );
  }

  @override
  move() {
    if (isMoveRight) {
      x += speed;
      if (x > _windowSize.width / 2) {
        x = _windowSize.width / 2;
      }
    }
    if (isMoveLeft) {
      x -= speed;
      if (x < 0) x = 0;
    }

    if (isMoveUp) {
      y -= speed;
      if (y < -playerSize / 2) {
        y = -playerSize / 2;
      }
    }

    if (isMoveDown) {
      y += speed;
      if (y > _windowSize.height - playerSize) {
        y = _windowSize.height - playerSize / 2;
      }
    }
    // isMoveRight = false;
    // isMoveLeft = false;
  }

}