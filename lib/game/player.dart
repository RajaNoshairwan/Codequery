import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'learning_game.dart';
import 'door.dart';
import 'laptop.dart';


class Player extends SpriteComponent
    with HasGameRef<LearningGame>, CollisionCallbacks, KeyboardHandler {
final double speed = 150;


Player() : super(size: Vector2(64, 64));


@override
  Future<void> onLoad() async {
    sprite = await Sprite.load('assets/images/player.png');
    add(RectangleHitbox());
  }


Vector2 moveDirection = Vector2.zero();


@override
void update(double dt) {
super.update(dt);
position += moveDirection * speed * dt;
// clamp to screen
  position.clamp(Vector2.zero() + size/2, game.size - size/2);
}


@override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
// basic keyboard support for debugging
moveDirection.setZero();
if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) moveDirection.x = -1;
if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) moveDirection.x = 1;
if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) moveDirection.y = -1;
if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) moveDirection.y = 1;
moveDirection.normalize();
return true;
}


@override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
if (other is Laptop) {
// when colliding with laptop, show quiz overlay
  game.showQuiz();
}
if (other is Door) {
if (other.isOpen) {
// TODO: advance to next level
}
}
}
}