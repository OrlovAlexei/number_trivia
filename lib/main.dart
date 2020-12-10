import 'package:flutter/material.dart';
import 'features/numberTrivia/presentation/page/numberTriviaPage.dart';
import 'injectionContainer.dart' as di;

void main() async {
  await di.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
      home: NumberTriviaPage(),
    );
  }
}
