import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyles {
  // displayLarge
  static final displayLarge = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: 24,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0.0,
    color: Color(0xFF4CAF50),
  );

  //
  // displayMedium
  static final displayMedium = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: 22,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0.0,
    color: Color(0xFF4CAF50),
  );

  //
  // displaySmall
  static final errorMessage = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: 20,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0.0,
    color: Color(0xFF4CAF50),
  );

  // headlineLarge
  static final filledTaskField = TextStyle(
    fontFamily: GoogleFonts.raleway().fontFamily,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    height: 1.0,
    letterSpacing: 0.0,
    color: Color(0xFF9C27B0),
  );

  // headlineMedium
  static final descriptionTaskField = TextStyle(
    fontFamily: GoogleFonts.spectral().fontFamily,
    fontSize: 14,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0.0,
    color: Color(0xFF9C27B0),
  );

  // headlineSmall:
  static final headlineSmall = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: 12,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0.0,
    color: Color(0xFF9C27B0),
  );

  // titleLarge
  static const promo = TextStyle(
    fontFamily: 'Lato',
    fontSize: 24,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: 0.0,
    color: Color(0xFF2196F3),
  );

  // titleMedium
  static const appBar = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 20,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w800,
    height: 1.0,
    letterSpacing: 0.0,
    color: Color(0xFF2196F3),
  );

  // titleSmall
  static const detailsMain = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0.0,
    color: Color(0xFF2196F3),
  );

  // bodyLarge
  static const bodyLarge = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 20,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w800,
    height: 1.0,
    letterSpacing: 0.0,
    color: Color(0xFFCC2A4B),
  );

  // bodyMedium
  static const description = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.0,
    color: Color(0xFFCC2A4B),
  );

  // bodySmall
  static final card = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: 0.0,
    color: Color(0xFFCC2A4B),
  );

  // labelLarge
  static final bottomNavigationMenu = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: 15,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    height: 2.5,
    letterSpacing: 0.0,
    color: Color(0xFFFF9800),
  );

  // labelMedium
  static final dropMenu = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: 0.0,
    color: Color(0xFFFF9800),
  );

  // labelSmall
  static final defaultListCardMain = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: 12,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    height: 1.0,
    letterSpacing: 0.0,
    color: Color(0xFFFF9800),
  );
}
