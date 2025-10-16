import 'package:flutter/material.dart';
import '../data/quiz_questions.dart';
import 'learning_game.dart';

class QuizOverlay extends StatefulWidget {
  final LearningGame game;
  const QuizOverlay({super.key, required this.game});

  @override
  State<QuizOverlay> createState() => _QuizOverlayState();
}


class _QuizOverlayState extends State<QuizOverlay> {
final TextEditingController controller = TextEditingController();
int attempts = 0;
late Map<String, String> q;


@override
void initState() {
super.initState();
q = quizQuestions.first; // choose first question for prototype
}


  void submit() {
final input = controller.text.trim();
attempts += 1;
if (input.toLowerCase() == q['answer']!.toLowerCase()) {
widget.game.onQuizResult(true);
} else {
if (attempts == 1) {
final hint = q['hint'] ?? 'Try again';
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hint: $hint')));
} else {
final expl = q['explanation'] ?? 'Answer: ${q['answer']}';
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Solution: $expl')));
}
}
}


@override
Widget build(BuildContext context) {
return Center(
child: Card(
margin: const EdgeInsets.symmetric(horizontal: 24),
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
Text(q['question'] ?? '', style: const TextStyle(fontSize: 18)),
const SizedBox(height: 12),
TextField(controller: controller, decoration: const InputDecoration(labelText: 'Fill blank')),
const SizedBox(height: 12),
Row(
mainAxisAlignment: MainAxisAlignment.end,
children: [
TextButton(onPressed: () { widget.game.overlays.remove('QuizOverlay'); widget.game.resumeEngine(); }, child: const Text('Cancel')),
ElevatedButton(onPressed: submit, child: const Text('Submit')),
],
)
],
),
),
),
);
}
}