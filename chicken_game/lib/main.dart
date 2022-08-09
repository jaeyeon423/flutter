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
  late SpriteAnimationComponent chicken;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    print('load the assets for the game');
    Image chickenImage = await images.load('chicken.png');
    var chickenAnimation = SpriteAnimation.fromFrameData(
      chickenImage,
      SpriteAnimationData.sequenced(
        amount: 14,
        stepTime: 0.1,
        textureSize: Vector2(32, 34),
      ),
    );
    chicken = SpriteAnimationComponent()
      ..animation = chickenAnimation
      ..size = Vector2(32, 34) * chickenScaleFactor
      ..position = Vector2.all(100);
    add(chicken);
  }

  @override
  void update(double dt) {
    super.update(dt);
    chicken.y += 1;
    chicken.x += 1;
  }
}
