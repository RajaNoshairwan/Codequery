import 'package:flutter/material.dart';
import 'game_screen.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  void _startGame(BuildContext context, String difficulty) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => GameScreen(level: difficulty)),
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
            ElevatedButton(
                onPressed: () => _startGame(context, 'Easy'),
                child: const Text('Easy')),
            ElevatedButton(
                onPressed: () => _startGame(context, 'Medium'),
                child: const Text('Medium')),
            ElevatedButton(
                onPressed: () => _startGame(context, 'Hard'),
                child: const Text('Hard')),
          ],
        ),
      ),
    );
  }
}
