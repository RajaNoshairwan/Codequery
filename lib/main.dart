import 'package:flutter/material.dart';
import 'package:codequest/screens/home_screen.dart';


void main() async {
WidgetsFlutterBinding.ensureInitialized();
runApp(const CodeQuestApp());
}


class CodeQuestApp extends StatelessWidget {
const CodeQuestApp({Key? key}) : super(key: key);


@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'CodeQuest',
theme: ThemeData(primarySwatch: Colors.blue),
home: const HomeScreen(),
);
}
}