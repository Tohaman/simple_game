import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:game/models/screen_object.dart';

class Bubble extends ScreenObject{
  double radius = 30;
  double speed = 1;
  late Size windowSize;

  Bubble(this.windowSize){
    setNewCoords();
  }

  void move() {
    x -= speed;
    if (x < (0 - radius * 2)) {
      setNewCoords();
    }
  }

  void setNewCoords() {
    x = windowSize.width + radius * 2 + rnd.nextDouble() * windowSize.width;
    y = rnd.nextDouble() * windowSize.height;
    speed = rnd.nextDouble() * 2 + 1;
    // radius = rnd.nextDouble() * 10 + 20;
  }

  Widget build() {
    return (visible)
        ? Positioned(
            top: y,
            left: x,
            child: CustomPaint(
              foregroundPainter: Circle(radius),
              child: Container(
                width: radius * 2,
                height: radius * 2,
              ),
            ))
        : SizedBox();
  }
}

class Circle extends CustomPainter {
  final double radius;

  Circle(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    Paint pen = Paint()
      ..strokeWidth = 2
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2);  //center of device
    // выводим наш круг по центру экрана
    canvas.drawCircle(center, radius, pen);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}