import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../utils/game_assets.dart';

class Laptop extends SpriteComponent with CollisionCallbacks {
  Laptop() : super(size: Vector2(64, 64));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(GameAssets.laptop);
    add(RectangleHitbox());
  }
}
