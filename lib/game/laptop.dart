import 'package:flame/components.dart';
import 'package:flame/collisions.dart';


class Laptop extends SpriteComponent with CollisionCallbacks {
Laptop() : super(size: Vector2(64, 64));


@override
Future<void> onLoad() async {
sprite = await Sprite.load('assets/images/laptop.png');
add(RectangleHitbox());
}
}