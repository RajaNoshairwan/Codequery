import 'package:flutter/material.dart';

class NextLevelOverlay extends StatelessWidget {
  final String currentLevel;
  final VoidCallback onNext;

  const NextLevelOverlay({
    super.key,
    required this.currentLevel,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    String next = currentLevel == 'Easy'
        ? 'Medium'
        : currentLevel == 'Medium'
            ? 'Hard'
            : 'Done';

    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              next == 'Done'
                  ? '🎉 You finished the game!'
                  : '✅ Level Complete! Next: $next',
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 16),
            if (next != 'Done')
              ElevatedButton(
                onPressed: onNext,
                child: const Text('Continue'),
              ),
          ],
        ),
      ),
    );
  }
}
