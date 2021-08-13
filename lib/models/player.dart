import 'package:flutter/material.dart';
import 'package:game/models/screen_object.dart';

class Player extends ScreenObject {

  Player(){

  }

  @override
  Widget build() {
    return Positioned(
        top: y,
        left: x,
        child: Text(">")
    );
  }

  @override
  move() {

  }

}