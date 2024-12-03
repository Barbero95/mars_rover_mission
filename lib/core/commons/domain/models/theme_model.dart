import 'package:flutter/material.dart';

class ThemeModel {
  final bool useMaterial3;
  final ThemeMode themeMode;

  ThemeModel({
    required this.useMaterial3,
    required this.themeMode,
  });

  ThemeModel copyWith({
    bool? useMaterial3,
    ThemeMode? themeMode,
  }) {
    return ThemeModel(
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
