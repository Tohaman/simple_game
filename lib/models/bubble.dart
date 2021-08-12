import 'dart:math';

import 'dart:ui';

class Bubble{
  double _x = 0.0;
    double get x => _x;

  double _y = 0.0;
    double get y => _y;

  double _radius = 50;
    double get radius => _radius;

  double _speed = 1;

  Bubble(Size windowSize){
    var rnd = Random();
    _y = rnd.nextDouble() * windowSize.height;
    _x = windowSize.width;
    _speed = rnd.nextDouble() * 2 + 1;
  }

  void move() {
    _x -= _speed;
  }
}