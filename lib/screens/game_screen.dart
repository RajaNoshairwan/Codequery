import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  final String level;
  const GameScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Level: $level')),
      body: Center(
        child: Text('Game started on $level level!',
            style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}


