import 'package:flutter/material.dart';
import 'package:todo_app/router/router.dart';

void main() async {
  runApp(const TodoApp());
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFFF82B10);
    return MaterialApp.router(
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
      routerConfig: _router.config(),
    );
  }
}
