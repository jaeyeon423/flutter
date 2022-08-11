import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tiled/tiled.dart';

class Fruit extends SpriteComponent with HasGameRef, CollisionCallbacks {
  final TiledObject fruit;

  Fruit(this.fruit);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('world/Apple.png')
      ..srcSize = Vector2.all(32);

    size = Vector2.all(32);

    position = Vector2(fruit.x, fruit.y);

    add(
      RectangleHitbox(
        size: Vector2(fruit.width, fruit.height),
        anchor: Anchor.center,
        position: size / 2,
      ),
    );

    debugMode = true;
  }
}
