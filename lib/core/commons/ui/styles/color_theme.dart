import 'package:flutter/material.dart';

class CustomColors {
  static ColorScheme get light {
    return const ColorScheme.light(
      primary: primary,
      secondary: secondary,
    );
  }

  static ColorScheme get dark {
    return const ColorScheme.dark(
      primary: primary,
      secondary: secondary,
    );
  }

  static const Color primary = Colors.deepPurpleAccent;
  static const Color secondary = Color.fromARGB(255, 209, 196, 233);
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
}
