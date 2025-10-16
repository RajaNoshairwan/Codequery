import 'package:flutter/material.dart';
import 'package:codequest/game/learning_game.dart';
import 'package:flame/game.dart';
import '../game/quiz_overlay.dart';


class LevelSelectScreen extends StatelessWidget {
const LevelSelectScreen({super.key});


void _startGame(BuildContext context, String difficulty) {
final game = LearningGame(difficulty: difficulty);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameWidget(
          game: game,
          overlayBuilderMap: {
            'QuizOverlay': (context, game) => QuizOverlay(game: game as LearningGame),
          },
          initialActiveOverlays: const [],
        ),
      ),
    );
}


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Select Level')),
body: Center(
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
ElevatedButton(onPressed: () => _startGame(context, 'Easy'), child: const Text('Easy')),
ElevatedButton(onPressed: () => _startGame(context, 'Medium'), child: const Text('Medium')),
ElevatedButton(onPressed: () => _startGame(context, 'Hard'), child: const Text('Hard')),
],
),
),
);
}
}