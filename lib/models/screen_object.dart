import 'dart:math';

import 'package:flutter/material.dart';

abstract class ScreenObject {
  double x = 0.0;
  double y = 0.0;
  bool visible = true;
  var rnd = Random();

  Widget build();

  move();
}