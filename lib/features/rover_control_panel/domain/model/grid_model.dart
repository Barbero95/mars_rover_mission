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

  bool zoomIn() {
    if (visibleRows > _Constants.minVisibleColumnsAndRows &&
        visibleColumns > _Constants.minVisibleColumnsAndRows) {
      visibleRows -= 1;
      visibleColumns -= 1;
      return true;
    }
    return false;
  }

  bool zoomOut() {
    if (visibleRows < rows && visibleColumns < columns) {
      visibleRows += 1;
      visibleColumns += 1;
      return true;
    }
    return false;
  }

  bool maxZoomIn() {
    final newVisibleRows = rows < _Constants.minVisibleColumnsAndRows
        ? rows
        : _Constants.minVisibleColumnsAndRows;
    final newVisibleColumns = columns < _Constants.minVisibleColumnsAndRows
        ? columns
        : _Constants.minVisibleColumnsAndRows;
    if (newVisibleRows == visibleRows && newVisibleColumns == visibleColumns) {
      return false;
    }
    visibleRows = newVisibleRows;
    visibleColumns = newVisibleColumns;
    return true;
  }

  bool maxZoomOut() {
    if (rows == visibleRows && columns == visibleColumns) {
      return false;
    }
    visibleRows = rows;
    visibleColumns = columns;
    return true;
  }

  (int, int, Offset) startOffset(PositionModel currentPosition) {
    final startX = (currentPosition.x - (visibleColumns / 2))
        .clamp(0, columns - visibleColumns)
        .roundToDouble();
    final startY = (currentPosition.y - (visibleRows / 2))
        .clamp(0, rows - visibleRows)
        .roundToDouble();
    return (
      startX.toInt(),
      startY.toInt(),
      Offset(startX, startY),
    );
  }
}
