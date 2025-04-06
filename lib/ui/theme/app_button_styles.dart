import 'package:flutter/material.dart';

class AppButtonStyles {
  static final ButtonStyle elevatedButtonStyleCreateTaskField = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Color(0xFFFFFFFF)),
    foregroundColor: WidgetStateProperty.all(Color(0x40000000)),
    side: WidgetStateProperty.all(
      BorderSide(
        color: Color(0x40A9A9A9),
        width: 2,
      ),
    ),
    overlayColor: WidgetStateProperty.all(Colors.white),
    shadowColor: WidgetStateProperty.all(Colors.white),
    elevation: WidgetStateProperty.all(0.1),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    ),
    textStyle: WidgetStateProperty.all(
      TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
