import 'package:flutter/material.dart';

const primaryColor = Colors.deepPurple;

final themeData = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  // scaffoldBackgroundColor: const Color.fromARGB(248, 48, 48, 48),
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    surface: Colors.white,
    onSurface: Colors.black,
    primary: Colors.red,
    onPrimary: Colors.black,
    secondary: Colors.lightGreen,
    onSecondary: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),

    backgroundColor: Color.fromARGB(48, 48, 48, 48),
    titleTextStyle: TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
  ),
  textTheme: TextTheme(
    titleMedium: const TextStyle(
      color: Colors.green,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      color: Colors.white.withAlpha(80),
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
  ),
  dividerColor: Colors.white24,
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
);
