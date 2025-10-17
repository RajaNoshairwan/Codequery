import 'package:flutter/material.dart';

class GameCompleteOverlay extends StatelessWidget {
  const GameCompleteOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          '🎉 Congratulations!\nYou completed all levels!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
