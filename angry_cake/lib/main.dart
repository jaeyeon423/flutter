import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

void main() {
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

    add(Obstacle(Vector2(60, -6), await loadSprite('pig.webp')));
    add(Obstacle(Vector2(60, 0), await loadSprite('crate.png')));
    add(Obstacle(Vector2(60, 8), await loadSprite('crate.png')));
    add(Obstacle(Vector2(60, 16), await loadSprite('crate.png')));
    add(Obstacle(Vector2(60, 24), await loadSprite('crate.png')));
  }
}

class Player extends BodyComponent with Tappable {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    add(SpriteComponent()
      ..sprite = await gameRef.loadSprite('red.webp')
      ..size = Vector2.all(6)
      ..anchor = Anchor.center);
  }

  @override
  Body createBody() {
    Shape shape = CircleShape()..radius = 3;
    BodyDef bodyDef = BodyDef(position: Vector2(10, 5), type: BodyType.dynamic);
    FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3, density: 1);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    body.applyLinearImpulse(Vector2(30, -15) * 25);
    return false;
  }
}

class Ground extends BodyComponent {
  final Vector2 gameSize;

  Ground(this.gameSize) : super(renderBody: false);

  @override
  Body createBody() {
    Shape shape = EdgeShape()
      ..set(
          Vector2(0, gameSize.y * .86), Vector2(gameSize.x, gameSize.y * .86));
    BodyDef bodyDef = BodyDef(userData: this, position: Vector2.zero());
    final fixtureDef = FixtureDef(shape, friction: 0.3);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class Obstacle extends BodyComponent {
  final Vector2 position;
  final Sprite sprite;
  Obstacle(this.position, this.sprite);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(SpriteComponent()
      ..sprite = sprite
      ..anchor = Anchor.center
      ..size = Vector2.all(4));
  }

  @override
  Body createBody() {
    final shape = PolygonShape();
    var vertices = [
      Vector2(-2, 2),
      Vector2(2, -2),
      Vector2(2, 2),
      Vector2(-2, -2),
    ];
    shape.set(vertices);
    FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3);
    BodyDef bodyDef =
        BodyDef(userData: this, position: position, type: BodyType.dynamic);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
