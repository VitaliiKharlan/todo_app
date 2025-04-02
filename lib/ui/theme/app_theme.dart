import 'package:flutter/material.dart';

import 'package:todo_app/ui/theme/app_text_style.dart';

const primaryColor = Colors.deepPurple;

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    surface: Colors.white,
    onSurface: Colors.black,
    primary: Colors.red,
    onPrimary: Colors.black,
    secondary: Colors.lightGreen,
    onSecondary: Colors.white,
    brightness: Brightness.light,
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
  textTheme: _textTheme,
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  dividerTheme: DividerThemeData(
    color: Colors.grey.withAlpha(20),
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromARGB(248, 48, 48, 48),
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    surface: Colors.white,
    onSurface: Colors.black,
    primary: Colors.red,
    onPrimary: Colors.black,
    secondary: Colors.lightGreen,
    onSecondary: Colors.white,
    brightness: Brightness.dark,
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
  textTheme: _textTheme,
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  dividerTheme: DividerThemeData(
    color: Colors.white.withAlpha(20),
  ),
);

final _textTheme = TextTheme(
  titleMedium: AppTextStyle.appBar.copyWith(
    color: Colors.green,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  ),
  bodyMedium: AppTextStyle.description.copyWith(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  ),
  labelSmall: AppTextStyle.promo.copyWith(
    color: Colors.white.withAlpha(80),
    fontSize: 14,
    fontWeight: FontWeight.w700,
  ),
);
