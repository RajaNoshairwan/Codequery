import 'package:flutter/material.dart';
import '../data/quiz_questions.dart';
import 'learning_game.dart';

class QuizOverlay extends StatefulWidget {
  final LearningGame game;
  const QuizOverlay({super.key, required this.game});

  @override
  State<QuizOverlay> createState() => _QuizOverlayState();
}

class _QuizOverlayState extends State<QuizOverlay>
    with TickerProviderStateMixin {
  final TextEditingController controller = TextEditingController();
  int attempts = 0;
  late Map<String, String> q;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  bool _isAnswerCorrect = false;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );
    _slideController.forward();

    q = _getQuestionByDifficulty(widget.game.difficulty);
  }

  Map<String, String> _getQuestionByDifficulty(String difficulty) {
    final questions = quizQuestionsByDifficulty[difficulty] ?? quizQuestions;
    return questions[0];
  }

  void submit() {
    final input = controller.text.trim();
    if (input.isEmpty) {
      _showCustomSnackBar('⚠️ Please enter an answer');
      return;
    }

    if (input.toLowerCase() == q['answer']!.toLowerCase()) {
      setState(() => _isAnswerCorrect = true);
      _showCustomSnackBar('🎉 Correct Answer!');
      widget.game.onQuizResult(true);

      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _closeQuiz();
      });
    } else {
      attempts += 1;
      if (attempts == 1) {
        _showCustomSnackBar('💡 Hint: ${q['hint'] ?? 'Try again!'}');
      } else if (attempts == 2) {
        _showCustomSnackBar('❌ Incorrect. Try again.');
      } else {
        _showCustomSnackBar('❌ Still incorrect. You can close this quiz.');
      }
    }
  }

  void _showCustomSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade700,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// ✅ FIXED FUNCTION
  /// This just hides the overlay and resumes the game — no navigation involved.
  void _closeQuiz() {
    if (!mounted) return;

        // Immediately hide overlay (visually & logically)
        widget.game.overlays.remove('QuizOverlay');
        widget.game.resumeEngine();

        // Then play the slide-out animation for smoothness
        _slideController.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurple.shade800,
                Colors.indigo.shade700,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.cyan.withOpacity(0.5),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.cyan.withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 5,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: _buildQuizCard(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 🔹 Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.cyan, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Text(
                'Code Challenge',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.cyan.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.layers, color: Colors.cyan, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'Attempt ${attempts + 1}',
                    style: const TextStyle(
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // 🔹 Question
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Text(
            q['question'] ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              height: 1.6,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 20),

        // 🔹 Answer Field
        TextField(
          controller: controller,
          enabled: !_isAnswerCorrect,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: 'Enter your answer',
            labelStyle: const TextStyle(color: Colors.white70, fontSize: 14),
            hintText: _isAnswerCorrect ? 'Correct! 🎉' : 'Type here...',
            hintStyle: TextStyle(
              color: _isAnswerCorrect
                  ? Colors.greenAccent
                  : Colors.white30,
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: _isAnswerCorrect
                    ? Colors.greenAccent
                    : Colors.cyan.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.cyan, width: 2),
            ),
            prefixIcon: Icon(
              _isAnswerCorrect ? Icons.check_circle : Icons.edit,
              color:
                  _isAnswerCorrect ? Colors.greenAccent : Colors.cyan,
            ),
            suffixIcon: _isAnswerCorrect
                ? const Icon(Icons.check_circle, color: Colors.greenAccent)
                : null,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
          ),
          onSubmitted: (_) {
            if (!_isAnswerCorrect) submit();
          },
        ),

        const SizedBox(height: 24),

        // 🔹 Actions
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: _closeQuiz, // ✅ just hides overlay
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12),
              ),
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: _isAnswerCorrect ? null : submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isAnswerCorrect
                    ? Colors.greenAccent
                    : Colors.cyan,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 8,
                disabledBackgroundColor: Colors.greenAccent,
              ),
              child: Text(
                _isAnswerCorrect ? 'Done! ✓' : 'Submit',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
