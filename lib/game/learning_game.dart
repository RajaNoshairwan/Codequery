import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'player.dart';
import 'door.dart';
import 'laptop.dart';


class LearningGame extends FlameGame with HasCollisionDetection, HasDraggables, HasTappables {
final String difficulty;
late Player player;
late Door door;
late Laptop laptop;


LearningGame({this.difficulty = 'Easy'});


@override
Future<void> onLoad() async {
await images.loadAll([ 'assets/images/player.png', 'assets/images/door_closed.png', 'assets/images/door_open.png', 'assets/images/laptop.png', 'assets/images/background.png' ]);


// background
add(SpriteComponent()
..sprite = await loadSprite('assets/images/background.png')
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
}
}
}