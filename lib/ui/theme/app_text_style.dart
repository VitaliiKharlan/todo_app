import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyle {
  static const appBar = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 20,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w800,
    height: 1.0,
    letterSpacing: 0.0,
  );

  static const dateProgressIndicator = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w800,
    height: 1.0,
    letterSpacing: 0.0,
  );

  static final card = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: 12,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0.0,
  );

  static const description = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.0,
  );

  static const promo = TextStyle(
    fontFamily: 'Lato',
    fontSize: 20,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: 0.0,
  );

  static const defaultListCardMain = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 20,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 0.0,
  );

  static final dropMenu = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: 15,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: 0.0,
  );
}
