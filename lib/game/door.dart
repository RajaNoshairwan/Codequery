import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../utils/game_assets.dart';

class Door extends SpriteComponent with CollisionCallbacks {
  bool isOpen = false;

  Door() : super(size: Vector2(96, 128));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(GameAssets.doorClosed);
    add(RectangleHitbox());
  }

  void open() async {
    isOpen = true;
    sprite = await Sprite.load(GameAssets.doorOpen);
  }
}
