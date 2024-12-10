import 'package:flutter/material.dart';

class PositionModel {
  int x;
  int y;

  PositionModel({
    required this.x,
    required this.y,
  });

  Offset get offset => Offset(
        x.toDouble(),
        y.toDouble(),
      );
}
