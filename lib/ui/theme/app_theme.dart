import 'package:flutter/material.dart';
import 'package:todo_app/ui/theme/app_button_styles.dart';

import 'package:todo_app/ui/theme/app_text_styles.dart';

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
  appBarTheme: AppBarTheme(
    // убирает тень.
    elevation: 0,
    // иконки в AppBar белые.
    iconTheme: IconThemeData(color: Colors.black),
    // фон AppBar
    backgroundColor: Color(0xFF42FF00),
    // заголовок AppBar
    titleTextStyle: AppTextStyles.appBar.copyWith(
      color: Colors.black,
    ),
  ),
  textTheme: _textTheme,
  listTileTheme: ListTileThemeData(
    titleTextStyle: AppTextStyles.appBar.copyWith(
      color: Colors.green,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    iconColor: Colors.green,
  ),
  dividerTheme: DividerThemeData(
    color: Colors.grey.withAlpha(20),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: AppButtonStyles.elevatedButtonStyleCreateTaskField,
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
  appBarTheme: AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Color(0xFF888888),
    titleTextStyle: AppTextStyles.appBar.copyWith(
      color: Colors.white,
    ),
  ),
  textTheme: _textTheme,
  listTileTheme: ListTileThemeData(
    titleTextStyle: AppTextStyles.appBar.copyWith(
      color: Colors.green,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    iconColor: Colors.green,
  ),
  dividerTheme: DividerThemeData(
    color: Colors.white.withAlpha(20),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: AppButtonStyles.elevatedButtonStyleCreateTaskField,
  ),
);

final _textTheme = TextTheme(
  displayLarge: AppTextStyles.displayLarge,
  displayMedium: AppTextStyles.displayMedium,
  displaySmall: AppTextStyles.displaySmall,
  //
  headlineLarge: AppTextStyles.filledTaskField,
  headlineMedium: AppTextStyles.descriptionTaskField,
  headlineSmall: AppTextStyles.headlineSmall,
  //
  titleLarge: AppTextStyles.promo,
  titleMedium: AppTextStyles.appBar,
  titleSmall: AppTextStyles.detailsMain,
  //
  bodyLarge: AppTextStyles.bodyLarge,
  bodyMedium: AppTextStyles.description,
  bodySmall: AppTextStyles.card,
  //
  labelLarge: AppTextStyles.bottomNavigationMenu,
  labelMedium: AppTextStyles.dropMenu,
  labelSmall: AppTextStyles.defaultListCardMain,
);
