import 'package:flutter/material.dart';
import 'level_select_screen.dart';


class HomeScreen extends StatelessWidget {
const HomeScreen({Key? key}) : super(key: key);


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('CodeQuest')),
body: Center(
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
const Text('Learn to code by playing!', style: TextStyle(fontSize: 20)),
const SizedBox(height: 24),
ElevatedButton(
onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LevelSelectScreen())),
child: const Text('Start Game'),
),
],
),
),
);
}
}