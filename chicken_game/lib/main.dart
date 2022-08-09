import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/material.dart' hide Image;

void main() {
  print('1. load the GameWidget with runApp');
  runApp(GameWidget(game: ChickenGame()));
}

class ChickenGame extends FlameGame {
  double chickenScaleFactor = 3.0;

  late SpriteComponent chickenSprite;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    print('load the assets for the game');
    Image chickenImage = await images.load('chicken.png');
    chickenSprite = SpriteComponent.fromImage(
      chickenImage,
      srcSize: Vector2(32, 34),
      srcPosition: Vector2(32, 0),
      size: Vector2(32, 34) * chickenScaleFactor,
      position: Vector2.all(100),
    );
    add(chickenSprite);
  }

  @override
  void update(double dt) {
    super.update(dt);
    chickenSprite.y += 1;
    chickenSprite.x += 1;
  }
}
