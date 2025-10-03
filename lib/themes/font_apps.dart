import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontApps {
  static final TextStyle _commonStyle = GoogleFonts.sora();

  static TextStyle displayLarge = _commonStyle.copyWith(
    fontSize: 57,
    fontWeight: FontWeight.w700,
    height: 1.12,
    letterSpacing: -1.5,
  );

  static TextStyle displayMedium = _commonStyle.copyWith(
    fontSize: 45,
    fontWeight: FontWeight.w600,
    height: 1.17,
    letterSpacing: -1,
  );

  static TextStyle displaySmall = _commonStyle.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w500,
    height: 1.25,
    letterSpacing: -0.5,
  );

  static TextStyle headlineLarge = _commonStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.5,
  );

  static TextStyle headlineMedium = _commonStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.25,
    letterSpacing: 0.2,
  );

  static TextStyle headlineSmall = _commonStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: 0.2,
  );

  static TextStyle titleLarge = _commonStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.2,
  );

  static TextStyle titleMedium = _commonStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0.2,
  );

  static TextStyle titleSmall = _commonStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0.4,
  );

  static TextStyle bodyLarge = _commonStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static TextStyle bodyMedium = _commonStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle bodySmall = _commonStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    height: 1.5,
  );

  static TextStyle labelLarge = _commonStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 1.2,
  );

  static TextStyle labelMedium = _commonStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 1.1,
  );

  static TextStyle labelSmall = _commonStyle.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w300,
    height: 1.2,
    letterSpacing: 1.1,
  );
}