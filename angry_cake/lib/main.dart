import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends Forge2DGame {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    Vector2 gameSize = screenToWorld(camera.viewport.effectiveSize);
    print(gameSize);
    add(Player());
    add(Ground(gameSize));
  }
}

class Player extends BodyComponent {
  @override
  Body createBody() {
    Shape shape = CircleShape()..radius = 3;
    BodyDef bodyDef = BodyDef(position: Vector2(10, 5), type: BodyType.dynamic);
    FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3, density: 1);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class Ground extends BodyComponent {
  final Vector2 gameSize;

  Ground(this.gameSize) : super(renderBody: false);

  @override
  Body createBody() {
    Shape shape = EdgeShape()
      ..set(Vector2(0, gameSize.y * .9), Vector2(gameSize.x, gameSize.y * .9));
    BodyDef bodyDef = BodyDef(userData: this, position: Vector2.zero());
    final fixtureDef = FixtureDef(shape, friction: 0.3);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
