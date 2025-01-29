import 'package:flutter/material.dart';
import 'package:todo_app/home_screen.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFFF82B10);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.grey,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          surface: Colors.white,
          onSurface: Colors.black,
          primary: Colors.yellowAccent,
          onPrimary: Colors.black,
          secondary: Colors.lightGreen,
          onSecondary: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
