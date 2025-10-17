import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'player.dart';
import 'package:flutter/material.dart' show Offset;
import 'door.dart';
import 'laptop.dart';
import '../utils/game_assets.dart';

class LearningGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  final String difficulty;
  final void Function(String message)? onMessage;
  late Player player;
  late Door door;
  late Laptop laptop;

  LearningGame({this.difficulty = 'Easy', this.onMessage});

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      GameAssets.player,
      GameAssets.doorClosed,
      GameAssets.doorOpen,
      GameAssets.laptop,
      GameAssets.background,
    ]);

    // background
    add(SpriteComponent()
      ..sprite = await loadSprite(GameAssets.background)
      ..size = size);

    // door
    door = Door()
      ..position = Vector2(size.x - 120, size.y / 2 - 32)
      ..anchor = Anchor.topLeft;
    add(door);

    // laptop
    laptop = Laptop()
      ..position = Vector2(size.x / 2 - 32, size.y / 2 - 32)
      ..anchor = Anchor.topLeft;
    add(laptop);

    // player
    player = Player()
      ..position = Vector2(64, size.y / 2)
      ..anchor = Anchor.center;
    add(player);
  }

  void showQuiz() {
    pauseEngine();
    overlays.add('QuizOverlay');
  }

  void onQuizResult(bool correct) {
    overlays.remove('QuizOverlay');
    resumeEngine();
    if (correct) {
      door.open();
      onMessage?.call('Door opened!');
    }
  }

// Nudge player position by a small offset (for on-screen buttons)
  void nudge(Offset delta) {
    final d = Vector2(delta.dx.toDouble(), delta.dy.toDouble());
    player.position += d * 10; // move 10px per press
    player.position
        .clamp(Vector2.zero() + player.size / 2, size - player.size / 2);
  }

// Interact with nearby objects (e.g., at laptop/door)
  void interact() {
    // Prevent re-triggering while overlay is already visible
    if (overlays.isActive('QuizOverlay')) {
      return;
    }
    // If the door is open and player is near it, show placeholder next step
    if (door.isOpen && (player.position - door.position).length < 80) {
      onMessage?.call('Next challenge coming soon...');
      return;
    }
    // Otherwise trigger quiz overlay when near laptop/door area
    if ((player.position - laptop.position).length < 120 ||
        (player.position - door.position).length < 120) {
      showQuiz();
    } else {
      onMessage?.call('Move closer to the laptop or door to interact.');
    }
  }
}
