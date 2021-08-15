import 'package:flutter/material.dart';
import 'package:game/models/screen_object.dart';

class Planet extends ScreenObject {
  var pNumber = 1;
  late Size windowSize;
  var radius = 30.0;
  var speed = 1.0;

  Planet(this.windowSize){
    setNewCoords();
  }

  Widget build() {
    return (visible)
        ? Positioned(
        top: y,
        left: x,
        child: Image.asset("assets/planets/planet$pNumber.png", width: radius * 2, height: radius * 2,)
        )
        : SizedBox();
  }

  void setNewCoords() {
    x = windowSize.width + radius * 2 + rnd.nextDouble() * windowSize.width;
    y = rnd.nextDouble() * windowSize.height;
    pNumber = rnd.nextInt(7) + 1;
    speed = 1 + pNumber * 0.1;
    // radius = rnd.nextDouble() * 10 + 20;
  }

  void move() {
    x -= speed;
    if (x < (0 - radius * 2)) {
      setNewCoords();
    }
  }

}