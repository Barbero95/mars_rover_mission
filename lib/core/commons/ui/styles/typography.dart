import 'package:flutter/material.dart';

class CustomFontSize {
  static const double s60 = 60;
  static const double s48 = 48;
  static const double s40 = 40;
  static const double s32 = 32;
  static const double s28 = 28;
  static const double s24 = 24;
  static const double s20 = 20;
  static const double s18 = 18;
  static const double s16 = 16;
  static const double s14 = 14;
  static const double s13 = 13;
}

class CustomFontWeight {
  /// w400
  static const FontWeight regular = FontWeight.w400;

  /// w600
  static const FontWeight semibold = FontWeight.w600;

  /// w700
  static const FontWeight bold = FontWeight.w700;
}

class CustomLineHeight {
  static const double h72 = 72;
  static const double h56 = 56;
  static const double h48 = 48;
  static const double h40 = 40;
  static const double h32 = 32;
  static const double h28 = 28;
  static const double h24 = 24;
  static const double h20 = 20;
  static const double h18 = 18;
  static const double h16 = 16;
}

class CustomLetterSpacing {
  static const double ls15 = 1.15;
  static const double ls10 = 1.10;
}

class CustomFontFamily {
  static const String georgia = 'Georgia';
  static const String roboto = 'Roboto';
}

class CystomTextStyle {
  // D I S P L A Y
  /// Georgia, w600 (semibold), s60
  static TextStyle displayXXL = const TextStyle(
    fontFamily: CustomFontFamily.georgia,
    fontWeight: CustomFontWeight.semibold,
    fontSize: CustomFontSize.s60,
  );

  /// Georgia, w600 (semibold), s48
  static TextStyle displayXL = displayXXL.copyWith(
    fontSize: CustomFontSize.s48,
  );

  // T I T L E
  /// Georgia, w600 (semibold), s40
  static TextStyle titleXL = const TextStyle(
    fontFamily: CustomFontFamily.georgia,
    fontWeight: CustomFontWeight.semibold,
    fontSize: CustomFontSize.s40,
  );

  /// Georgia, w600 (semibold), s32
  static TextStyle titleL = titleXL.copyWith(
    fontSize: CustomFontSize.s32,
  );

  /// Georgia, w600 (semibold), s28
  static TextStyle titleM = titleXL.copyWith(
    fontSize: CustomFontSize.s28,
  );

  /// Georgia, w600 (semibold), s24
  static TextStyle titleS = titleXL.copyWith(
    fontSize: CustomFontSize.s24,
  );

  /// Georgia, w600 (semibold), s20
  static TextStyle titleXS = titleXL.copyWith(
    fontSize: CustomFontSize.s20,
  );

  /// Roboto, w600 (semibold), s16, ls15
  static TextStyle titleSection = titleXL.copyWith(
    fontFamily: CustomFontFamily.roboto,
    fontSize: CustomFontSize.s16,
    letterSpacing: CustomLetterSpacing.ls15,
  );

  // P A R A G R A P H
  /// Roboto, w400 (regular), s18
  static TextStyle paragraphXLdefault = const TextStyle(
    fontFamily: CustomFontFamily.roboto,
    fontWeight: CustomFontWeight.regular,
    fontSize: CustomFontSize.s18,
  );

  /// Roboto, w600 (semibold), s18
  static TextStyle paragraphXLsemibold = paragraphXLdefault.copyWith(
    fontWeight: CustomFontWeight.semibold,
  );

  /// Roboto, w700 (bold), s18
  static TextStyle paragraphXLbold = paragraphXLdefault.copyWith(
    fontWeight: CustomFontWeight.bold,
  );

  /// Roboto, w400 (regular), s16
  static TextStyle paragraphLdefault = paragraphXLdefault.copyWith(
    fontSize: CustomFontSize.s16,
    // height: YuLineHeight.h24,
  );

  /// Roboto, w600 (semibold), s16
  static TextStyle paragraphLsemibold = paragraphLdefault.copyWith(
    fontWeight: CustomFontWeight.semibold,
  );

  /// Roboto, w700 (regular), s16
  static TextStyle paragraphLbold = paragraphLdefault.copyWith(
    fontWeight: CustomFontWeight.bold,
  );

  /// Roboto, w400 (regular), s14
  static TextStyle paragraphMdefault = paragraphXLdefault.copyWith(
    fontSize: CustomFontSize.s14,
    // height: YuLineHeight.h20,
  );

  /// Roboto, w600 (semibold), s14
  static TextStyle paragraphMsemibold = paragraphMdefault.copyWith(
    fontWeight: CustomFontWeight.semibold,
  );

  /// Roboto, w700 (bold), s14
  static TextStyle paragraphMbold = paragraphMdefault.copyWith(
    fontWeight: CustomFontWeight.bold,
  );

  /// Roboto, w400 (regular), s13
  static TextStyle paragraphSdefault = paragraphXLdefault.copyWith(
    fontSize: CustomFontSize.s13,
    // height: YuLineHeight.h18,
  );

  /// Roboto, w600 (semibold), s13
  static TextStyle paragraphSsemibold = paragraphSdefault.copyWith(
    fontWeight: CustomFontWeight.semibold,
  );

  /// Roboto, w700 (bold), s13
  static TextStyle paragraphSbold = paragraphSdefault.copyWith(
    fontWeight: CustomFontWeight.bold,
  );

  /// Roboto, w400 (regular), s14, underline
  static TextStyle linkM = paragraphMdefault.copyWith(
    decoration: TextDecoration.underline,
  );

  // U I   T E X T
  /// Roboto, w600 (semibold), s16, ls10
  static TextStyle uiTextL = const TextStyle(
    fontFamily: CustomFontFamily.roboto,
    fontWeight: CustomFontWeight.semibold,
    fontSize: CustomFontSize.s16,
    // height: YuLineHeight.h24,
    letterSpacing: CustomLetterSpacing.ls10,
  );

  /// Roboto, w600 (semibold), s14, ls10
  static TextStyle uiTextM = uiTextL.copyWith(
    fontSize: CustomFontSize.s14,
  );

  /// Roboto, w600 (semibold), s13, ls10
  static TextStyle uiTextS = uiTextM.copyWith(
    fontSize: CustomFontSize.s13,
  );
}
