import 'package:angry_cake/actors/player.dart';
import 'package:angry_cake/world/ground.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Enemy extends BodyComponent with ContactCallbacks {
  final Vector2 position;
  final Sprite sprite;
  late Sprite cloudSprite;

  Enemy(this.position, this.sprite);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    add(
      SpriteComponent()
        ..sprite = sprite
        ..anchor = Anchor.center
        ..size = Vector2.all(4),
    );
    cloudSprite = await gameRef.loadSprite('cloud.webp');
  }

  @override
  Body createBody() {
    final shape = PolygonShape();
    final vertices = [
      Vector2(-2, -2),
      Vector2(2, -2),
      Vector2(2, 2),
      Vector2(-2, 2)
    ];
    shape.set(vertices);
    final FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3);
    final BodyDef bodyDef =
        BodyDef(userData: this, position: position, type: BodyType.dynamic);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  void onCollision(Set<Vector2> points, Object other) {
    if (other is Player) {
    print("collision playrt");
    }
  }

  @override
  void beginContact(Object other, Contact contact) {
    print("beginContact\n");
    if (other is Ground) {
      print('hit player');
      add(
        SpriteComponent()
          ..sprite = cloudSprite
          ..anchor = Anchor.center
          ..size = Vector2.all(4),
      );
      Future.delayed(
        const Duration(milliseconds: 100),
        removeFromParent,
      );
    }
  }
}
