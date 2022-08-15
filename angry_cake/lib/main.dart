import 'package:angry_cake/actors/enemy.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

import 'actors/player.dart';
import 'world/ground.dart';
import 'world/obstacle.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends Forge2DGame with HasTappables {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    Vector2 gameSize = screenToWorld(camera.viewport.effectiveSize);
    add(SpriteComponent()
      ..sprite = await loadSprite('background.webp')
      ..size = size);
    add(Ground(gameSize));
    add(Player());

    add(Enemy(Vector2(60, -6), await loadSprite('pig.webp')));
    // add(Obstacle(Vector2(60, 0), await loadSprite('barrel.png')));
    // add(Obstacle(Vector2(60, 10), await loadSprite('crate.png')));
    // add(Obstacle(Vector2(60, 20), await loadSprite('crate.png')));
    // add(Obstacle(Vector2(60, 30), await loadSprite('crate.png')));
    // add(Obstacle(Vector2(60, 40), await loadSprite('crate.png')));
  }
}
