import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:codequest/game/learning_game.dart';
import '../game/quiz_overlay.dart';

class GameScreen extends StatelessWidget {
  final String level;
  const GameScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final game = LearningGame(
      difficulty: level,
      onMessage: (msg) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg))),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Level: $level')),
      body: Stack(
        children: [
          GameWidget(
            game: game,
            overlayBuilderMap: {
              'QuizOverlay': (ctx, g) => QuizOverlay(game: g as LearningGame),
            },
            initialActiveOverlays: const [],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => game.nudge(const Offset(-1, 0)),
                  child: const Text('Left'),
                ),
                ElevatedButton(
                  onPressed: game.interact,
                  child: const Text('Interact'),
                ),
                ElevatedButton(
                  onPressed: () => game.nudge(const Offset(1, 0)),
                  child: const Text('Right'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


