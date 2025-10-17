import 'package:flutter/material.dart';
import 'learning_game.dart';

class LevelMessageOverlay extends StatefulWidget {
  final LearningGame game;
  final String message;
  const LevelMessageOverlay({
    super.key,
    required this.game,
    required this.message,
  });

  @override
  State<LevelMessageOverlay> createState() => _LevelMessageOverlayState();
}

class _LevelMessageOverlayState extends State<LevelMessageOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    // Auto close after 2.5 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        widget.game.overlays.remove('LevelMessageOverlay');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        color: Colors.black.withOpacity(0.6),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.cyanAccent, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Text(
              widget.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 1.2,
                shadows: [
                  Shadow(color: Colors.white, blurRadius: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
