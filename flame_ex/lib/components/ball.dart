import 'package:flame/components.dart';
import 'package:flutter/material.dart' show Color;

class Ball extends CircleComponent with HasGameRef {
  static const double ballRadius = 15.0;
  static const double friction = 0.98;

  Vector2 velocity = Vector2.zero();
  bool isDragging = false;
  Vector2? dragStart;
  Vector2? currentDragPosition;

  Ball() : super(radius: ballRadius) {
    paint.color = const Color(0xFFFFFFFF);
    position = Vector2(100, 500); // Initial position
  }

  @override
  void update(double dt) {
    if (!isDragging) {
      position += velocity * dt;
      velocity *= friction;

      // Bounce off walls
      if (position.x < ballRadius) {
        position.x = ballRadius;
        velocity.x = -velocity.x * 0.8;
      } else if (position.x > gameRef.size.x - ballRadius) {
        position.x = gameRef.size.x - ballRadius;
        velocity.x = -velocity.x * 0.8;
      }

      if (position.y < ballRadius) {
        position.y = ballRadius;
        velocity.y = -velocity.y * 0.8;
      } else if (position.y > gameRef.size.y - ballRadius) {
        position.y = gameRef.size.y - ballRadius;
        velocity.y = -velocity.y * 0.8;
      }
    }
  }

  void startDrag(Vector2 position) {
    dragStart = position;
    currentDragPosition = position;
    isDragging = true;
  }

  void updateDrag(Vector2 position) {
    currentDragPosition = position;
  }

  void endDrag(Vector2 position) {
    if (isDragging && dragStart != null && currentDragPosition != null) {
      velocity = (dragStart! - currentDragPosition!) * 0.1;
      isDragging = false;
      dragStart = null;
      currentDragPosition = null;
    }
  }

  void cancelDrag() {
    isDragging = false;
    dragStart = null;
    currentDragPosition = null;
  }
}
