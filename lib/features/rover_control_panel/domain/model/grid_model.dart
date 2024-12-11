import 'dart:ui';

import 'package:mars_rover_mission/features/rover_control_panel/export_rover_control_panel.dart';

class _Constants {
  static const int minVisibleColumnsAndRows = 5;
}

class GridModel {
  final int columns;
  final int rows;
  late int visibleColumns;
  late int visibleRows;
  final List<PositionModel> obstacles;

  GridModel({
    required this.columns,
    required this.rows,
    required this.obstacles,
  }) {
    visibleColumns = columns;
    visibleRows = rows;
  }

  @override
  String toString() =>
      'GridModel(columns: $columns, rows: $rows, obstacles: $obstacles)';

  void zoomIn() {
    if (visibleRows > _Constants.minVisibleColumnsAndRows &&
        visibleColumns > _Constants.minVisibleColumnsAndRows) {
      visibleRows -= 1;
      visibleColumns -= 1;
    }
  }

  void zoomOut() {
    if (visibleRows < rows && visibleColumns < columns) {
      visibleRows += 1;
      visibleColumns += 1;
    }
  }

  Offset startOffset(PositionModel currentPosition) {
    final startX = (currentPosition.x - (visibleColumns / 2))
        .clamp(0, columns - visibleColumns)
        .roundToDouble();
    final startY = (currentPosition.y - (visibleRows / 2))
        .clamp(0, rows - visibleRows)
        .roundToDouble();
    return Offset(startX, startY);
  }
}
