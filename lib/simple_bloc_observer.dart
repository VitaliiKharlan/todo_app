import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';

class TODOApplication extends StatelessWidget {
  const TODOApplication({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: const MainScreen(),
    );
  }
}
