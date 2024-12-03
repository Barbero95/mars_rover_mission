import 'package:flutter/material.dart';

class Spaces {
  // U N I V E R S A L   S P A C E S   (use them as values for margins, paddings)
  /// {@template space_zero}
  /// 0
  /// {@endtemplate}
  static const double zero = 0;

  /// {@template space_XXXS}
  /// 4
  /// {@endtemplate}
  static const double spaceXXXS = 4;

  /// {@template space_XXS}
  /// 8
  /// {@endtemplate}
  static const double spaceXXS = 8;

  /// {@template space_XS}
  /// 16
  /// {@endtemplate}
  static const double spaceXS = 16;

  /// {@template space_S}
  /// 24
  /// {@endtemplate}
  static const double spaceS = 24;

  /// {@template space_M}
  /// 32
  /// {@endtemplate}
  static const double spaceM = 32;

  /// {@template space_L}
  /// 40
  /// {@endtemplate}
  static const double spaceL = 40;

  /// {@template space_XL}
  /// 56
  /// {@endtemplate}
  static const double spaceXL = 56;

  /// {@template space_XXL}
  /// 80
  /// {@endtemplate}
  static const double spaceXXL = 80;

  /// {@template space_XXXL}
  /// 96
  /// {@endtemplate}
  static const double spaceXXXL = 96;

  // V E R T I C A L   S P A C E S   (use them as vertical containers to create space)

  /// Creates a SizedBox with the desired [height]
  static Widget verticalSpace(double height) {
    return SizedBox(height: height);
  }

  /// Vertical
  ///{@macro space_XXXS}
  static Widget verticalXXXS() {
    return verticalSpace(spaceXXXS);
  }

  /// Vertical
  ///{@macro space_XXS}
  static Widget verticalXXS() {
    return verticalSpace(spaceXXS);
  }

  /// Vertical
  ///{@macro space_XS}
  static Widget verticalXS() {
    return verticalSpace(spaceXS);
  }

  /// Vertical
  ///{@macro space_S}
  static Widget verticalS() {
    return verticalSpace(spaceS);
  }

  /// Vertical
  ///{@macro space_M}
  static Widget verticalM() {
    return verticalSpace(spaceM);
  }

  /// Vertical
  ///{@macro space_L}
  static Widget verticalL() {
    return verticalSpace(spaceL);
  }

  /// Vertical
  ///{@macro space_XL}
  static Widget verticalXL() {
    return verticalSpace(spaceXL);
  }

  /// Vertical
  ///{@macro space_XXL}
  static Widget verticalXXL() {
    return verticalSpace(spaceXXL);
  }

  /// Vertical
  ///{@macro space_XXXL}
  static Widget verticalXXXL() {
    return verticalSpace(spaceXXXL);
  }

  // H O R I Z O N T A L   S P A C E S   (use them as horizontal containers to create space)

  /// Creates a SizedBox with the desired [width]
  static Widget horizontalSpace(double width) {
    return SizedBox(width: width);
  }

  /// Horizontal
  ///{@macro space_XXXS}
  static Widget horizontalXXXS() {
    return horizontalSpace(spaceXXXS);
  }

  /// Horizontal
  ///{@macro space_XXS}
  static Widget horizontalXXS() {
    return horizontalSpace(spaceXXS);
  }

  /// Horizontal
  ///{@macro space_XS}
  static Widget horizontalXS() {
    return horizontalSpace(spaceXS);
  }

  /// Horizontal
  ///{@macro space_S}
  static Widget horizontalS() {
    return horizontalSpace(spaceS);
  }

  /// Horizontal
  ///{@macro space_M}
  static Widget horizontalM() {
    return horizontalSpace(spaceM);
  }

  /// Horizontal
  ///{@macro space_L}
  static Widget horizontalL() {
    return horizontalSpace(spaceL);
  }

  /// Horizontal
  ///{@macro space_XL}
  static Widget horizontalXL() {
    return horizontalSpace(spaceXL);
  }

  /// Horizontal
  ///{@macro space_XXL}
  static Widget horizontalXXL() {
    return horizontalSpace(spaceXXL);
  }
}
