import 'package:flutter/material.dart';

import 'package:todo_app/ui/theme/app_text_style.dart';

const primaryColor = Colors.deepPurple;

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSeed(
    // Используется как основной цвет для генерации всех остальных цветов схемы (если не заданы явно).
    seedColor: primaryColor,
    // Определяет цвет фона для карточек, NavigationBar, BottomSheet и других элементов UI.
    surface: Colors.white,
    // Цвет текста и иконок, которые располагаются на surface.
    onSurface: Colors.black,
    // Главный цвет приложения, используется для кнопок, индикаторов, AppBar, FAB и других важных элементов.
    primary: Colors.red,
    // Цвет текста и иконок, которые располагаются на primary.
    onPrimary: Colors.blue[100],
    // Вторичный цвет, используется для выделения менее важных кнопок, тегов, переключателей и акцентов.
    secondary: Colors.lightGreen,
    // Цвет текста и иконок, которые располагаются на secondary.
    onSecondary: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    // убирает тень.
    elevation: 0,
    // иконки в AppBar белые.
    iconTheme: IconThemeData(color: Colors.white),
    // фон AppBar
    backgroundColor: Color(0xFF42FF00),
    // заголовок AppBar
    titleTextStyle: TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
  ),
  textTheme: _textTheme,
  listTileTheme: ListTileThemeData(
    titleTextStyle: AppTextStyle.appBar.copyWith(
      color: Colors.green,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    iconColor: Colors.green,
  ),
  dividerTheme: DividerThemeData(
    color: Colors.grey.withAlpha(20),
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF146464),
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    surface: Color(0xFF5A2323),
    onSurface: Color(0xFFFFFFFF),
    primary: Colors.red,
    onPrimary: Colors.black,
    secondary: Colors.lightGreen,
    onSecondary: Colors.white,
    brightness: Brightness.dark,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Color(0xFF888888),
    titleTextStyle: TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
  ),
  textTheme: _textTheme,
  listTileTheme: ListTileThemeData(
    titleTextStyle: AppTextStyle.appBar.copyWith(
      color: Colors.green,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    iconColor: Colors.green,
  ),

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
  bodySmall: AppTextStyle.card,
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
