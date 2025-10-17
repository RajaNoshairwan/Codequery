// In your data/quiz_questions.dart file

final List<Map<String, String>> quizQuestions = [
  {
    'question': 'What does "var" mean in programming?',
    'answer': 'variable',
    'hint': 'It\'s short for...',
    'explanation': 'var is short for variable, a named storage location for data',
  },
];

// Add this new map for difficulty-based questions
final Map<String, List<Map<String, String>>> quizQuestionsByDifficulty = {
  'Easy': [
    {
      'question': 'What does "var" mean in programming?',
      'answer': 'variable',
      'hint': 'It\'s short for...',
      'explanation': 'var is short for variable, a named storage location for data',
    },
    {
      'question': 'What symbol is used for comments in Dart?',
      'answer': '//',
      'hint': 'Two forward slashes',
      'explanation': '// is used for single-line comments in Dart',
    },
  ],
  'Medium': [
    {
      'question': 'What is a function that returns no value called in Dart?',
      'answer': 'void',
      'hint': 'It means "empty"...',
      'explanation': 'void is a return type for functions that don\'t return anything',
    },
    {
      'question': 'What keyword is used to define a class in Dart?',
      'answer': 'class',
      'hint': 'Blueprint for objects',
      'explanation': 'class is used to define a new class blueprint',
    },
  ],
  'Hard': [
    {
      'question': 'What design pattern does Flutter primarily use for state management in StatefulWidget?',
      'answer': 'setState',
      'hint': 'Method to update state...',
      'explanation': 'setState() is used to notify Flutter framework of state changes',
    },
    {
      'question': 'What is a widget that doesn\'t change its state called?',
      'answer': 'stateless',
      'hint': 'No state means...',
      'explanation': 'A StatelessWidget is immutable and doesn\'t change during its lifetime',
    },
  ],
};