import 'package:flame/components.dart';
import 'package:flutter/material.dart' show Color;

class Background extends RectangleComponent {
  Background() : super(size: Vector2(800, 600)) {
    paint.color = const Color(0xFF4CAF50); // Green color for grass
    position = Vector2.zero();
  }
}
