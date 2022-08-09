import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart' hide Image;

void main() {
  print('1. load the GameWidget with runApp');
  runApp(GameWidget(game: ChickenGame()));
}

class ChickenGame extends FlameGame with HasDraggables {
  double chickenScaleFactor = 3.0;

  late SpriteAnimationComponent chicken;
  late final JoystickComponent joystick;
  bool chickenFlipped = false;
  late SpriteComponent background;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    print('load the assets for the game');
    background = SpriteComponent()
      ..sprite = await loadSprite('back.png')
      ..size = size;
    add(background);
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

    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();

    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    add(joystick);
  }

  @override
  void update(double dt) {
    super.update(dt);
    chicken.position.add(joystick.relativeDelta * 300 * dt);
    if (joystick.relativeDelta[0] < 0 && chickenFlipped) {
      chickenFlipped = false;
      chicken.flipHorizontallyAroundCenter();
    }

    if (joystick.relativeDelta[0] > 0 && !chickenFlipped) {
      chickenFlipped = true;
      chicken.flipHorizontallyAroundCenter();
    }
  }
}
