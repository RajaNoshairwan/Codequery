// lib/game/level_message_overlay.dart

import 'package:flutter/material.dart';
import '../screens/game_screen.dart'; // adjust import if needed

import 'learning_game.dart';

class LevelMessageOverlay extends StatelessWidget {
  final LearningGame game;
  final String message;

  const LevelMessageOverlay({
    super.key,
    required this.game,
    required this.message,
  });

  // Helper: determine next level based on current difficulty
  String? _getNextLevel(String currentLevel) {
    switch (currentLevel.toLowerCase()) {
      case 'easy':
        return 'Medium';
      case 'medium':
        return 'Hard';
      case 'hard':
        return null; // no next level
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final nextLevel = _getNextLevel(game.difficulty);

    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade800.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 20),
            if (nextLevel != null)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => GameScreen(level: nextLevel),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward, color: Colors.black),
                label: Text(
                  'Go to $nextLevel Level',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              )
            else
              const Text(
                "🎉 You've completed all levels!",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
