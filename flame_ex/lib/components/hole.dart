import 'package:flame/components.dart';
import 'package:flutter/material.dart' show Color;

class Hole extends CircleComponent {
  static const double holeRadius = 20.0;

  Hole() : super(radius: holeRadius) {
    paint.color = const Color(0xFF000000);
    position = Vector2(300, 100); // Initial position at top center
  }

  bool isBallInHole(Vector2 ballPosition) {
    return (position - ballPosition).length < holeRadius;
  }
}
