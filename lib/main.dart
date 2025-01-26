import 'package:flutter/material.dart';
import 'package:todo_app/theme/app_theme.dart';

void main() {
  runApp(const MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO application',
      theme: darkTheme,
      home: Scaffold(
        backgroundColor: Color(0xFF2E335A),
      ),
    );
  }
}
