import 'package:flutter/material.dart';
import 'package:flutter_template/core/commons/domain/models/export_models.dart';
import 'package:flutter_template/core/commons/ui/styles/export_styles.dart';

// To create a theme color with only one primary (like on material3),
// set this line and substitute colorScheme for this parameter:
// colorSchemeSeed: ColorTheme.primary

class AppTheme {
  static ThemeData lightTheme(ThemeModel themeModel) => ThemeData(
        colorScheme: CustomColors.light,
        useMaterial3: themeModel.useMaterial3,
        brightness: Brightness.light,
      );

  static ThemeData darkTheme(ThemeModel themeModel) => ThemeData(
        colorScheme: CustomColors.dark,
        useMaterial3: themeModel.useMaterial3,
        brightness: Brightness.dark,
      );
}
