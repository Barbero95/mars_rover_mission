import 'package:flutter/material.dart';

@immutable
class PositionModel {
  final int x;
  final int y;

  const PositionModel({
    required this.x,
    required this.y,
  });

  Offset get offset => Offset(
        x.toDouble(),
        y.toDouble(),
      );

  PositionModel copyWith({
    int? x,
    int? y,
  }) {
    return PositionModel(
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }

  @override
  String toString() => '(x: $x, y: $y)';

  @override
  bool operator ==(covariant PositionModel other) {
    if (identical(this, other)) return true;

    return other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
