import 'package:flutter/material.dart';

import 'package:todo_app/router/router.dart';
import 'package:todo_app/ui/theme/app_theme.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: themeData,
      routerConfig: _router.config(),
    );
  }
}
