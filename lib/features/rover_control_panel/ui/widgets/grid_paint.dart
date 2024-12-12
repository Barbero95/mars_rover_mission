import 'package:flutter/material.dart';
import 'package:mars_rover_mission/features/rover_control_panel/export_rover_control_panel.dart';

class GridPaint extends CustomPainter {
  final int rows;
  final int columns;
  final Offset startOffset;
  final List<PositionModel> obstacles;
  final RoverModel rover;

  GridPaint({
    required this.rows,
    required this.columns,
    required this.startOffset,
    required this.obstacles,
    required this.rover,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final obstaclePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final roverPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final cellWidth = size.width / columns;
    final cellHeight = size.height / rows;

    // ---------- Start Grid ----------
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns; col++) {
        final rect = Rect.fromLTWH(
          col * cellWidth,
          row * cellHeight,
          cellWidth,
          cellHeight,
        );
        canvas.drawRect(rect, gridPaint);
      }
    }
    // ---------- End Grid ----------

    // ---------- Start Obstacles ----------
    for (final obstacle in obstacles) {
      final x = (obstacle.x - startOffset.dx) * cellWidth;
      final y = (obstacle.y - startOffset.dy) * cellHeight;
      if (x >= 0 && y >= 0 && x < size.width && y < size.height) {
        canvas.drawRect(
          Rect.fromLTWH(x, y, cellWidth, cellHeight),
          obstaclePaint,
        );
      }
    }
    // ---------- End Obstacles ----------

    // ---------- Start Border ----------
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      borderPaint,
    );
    // ---------- End Border ---------

    // ---------- Start Rover ----------
    final roverX =
        (rover.currentPosition.x - startOffset.dx) * cellWidth + cellWidth / 2;
    final roverY = (rover.currentPosition.y - startOffset.dy) * cellHeight +
        cellHeight / 2;

    if (roverX >= 0 &&
        roverY >= 0 &&
        roverX < size.width &&
        roverY < size.height) {
      final roverPath = Path();
      switch (rover.currentDirection) {
        case DirectionType.N:
          roverPath.moveTo(roverX, roverY - cellHeight / 3);
          roverPath.lineTo(roverX - cellWidth / 3, roverY + cellHeight / 3);
          roverPath.lineTo(roverX + cellWidth / 3, roverY + cellHeight / 3);
        case DirectionType.S:
          roverPath.moveTo(roverX, roverY + cellHeight / 3);
          roverPath.lineTo(roverX - cellWidth / 3, roverY - cellHeight / 3);
          roverPath.lineTo(roverX + cellWidth / 3, roverY - cellHeight / 3);
        case DirectionType.E:
          roverPath.moveTo(roverX + cellWidth / 3, roverY);
          roverPath.lineTo(roverX - cellWidth / 3, roverY - cellHeight / 3);
          roverPath.lineTo(roverX - cellWidth / 3, roverY + cellHeight / 3);
        case DirectionType.W:
          roverPath.moveTo(roverX - cellWidth / 3, roverY);
          roverPath.lineTo(roverX + cellWidth / 3, roverY - cellHeight / 3);
          roverPath.lineTo(roverX + cellWidth / 3, roverY + cellHeight / 3);
      }
      roverPath.close();
      canvas.drawPath(roverPath, roverPaint);
    }
    // ---------- End Rover ----------
  }

  @override
  bool shouldRepaint(GridPaint oldDelegate) {
    return oldDelegate.rows != rows ||
        oldDelegate.columns != columns ||
        oldDelegate.obstacles != obstacles ||
        oldDelegate.startOffset != startOffset ||
        oldDelegate.rover.currentPosition != rover.currentPosition ||
        oldDelegate.rover.currentDirection != rover.currentDirection;
  }
}
