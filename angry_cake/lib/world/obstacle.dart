import 'package:angry_cake/actors/enemy.dart';
import 'package:angry_cake/actors/player.dart';
import 'package:angry_cake/world/ground.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Obstacle extends BodyComponent with ContactCallbacks {
  final Vector2 position;
  final Sprite sprite;
  // late final AudioPool woodCollisionSfx;
  Obstacle(this.position, this.sprite);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(SpriteComponent()
      ..sprite = sprite
      ..anchor = Anchor.center
      ..size = Vector2.all(4));
    // woodCollisionSfx =
    //     await AudioPool.create('audio/sfx/wood_collision.mp3', maxPlayers: 4);
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

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    if (other is Ground || other is Player || other is Enemy) {
      // woodCollisionSfx.start();
    }
  }
}
