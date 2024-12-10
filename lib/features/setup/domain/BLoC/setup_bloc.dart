import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mars_rover_mission/features/rover_control_panel/export_rover_control_panel.dart';

class _Constants {
  static const defaultGrid = 200;
  static const defaultCommands = 'FFRRFFFRL';
}

class SetupBloc {
  late final TextEditingController _columnsTE;
  late final TextEditingController _rowsTE;
  late final TextEditingController _commandsTE;
  int numberOfObstacles = 10;

  TextEditingController get columnsTE => _columnsTE;
  TextEditingController get rowsTE => _rowsTE;
  TextEditingController get commandsTE => _commandsTE;

  SetupBloc() {
    _columnsTE = TextEditingController(
      text: '${_Constants.defaultGrid}',
    );
    _rowsTE = TextEditingController(
      text: '${_Constants.defaultGrid}',
    );
    _commandsTE = TextEditingController(
      text: _Constants.defaultCommands,
    );
  }

  void dispose() {
    _columnsTE.dispose();
    _rowsTE.dispose();
    _commandsTE.dispose();
  }

  void navigateToPanelControl(BuildContext context) {
    final random = Random();
    final rows = int.tryParse(_rowsTE.text.trim());
    final columns = int.tryParse(_columnsTE.text.trim());

    if (rows is! int || columns is! int) {
      // TODO(david): Show error message
      return;
    }

    final commandsParsed = _commandsTE.text.split('').map(
          CommandType.fromText,
        );

    if (commandsParsed.any((command) => command == null)) {
      // TODO(david): Show error message
      return;
    }

    context.push(
      RoverControlPanelRoutes.roverControlPanel,
      extra: RoverControlPanelExtra(
        grid: GridModel(
          columns: columns,
          rows: rows,
          obstacles: List.generate(
            numberOfObstacles,
            (_) => PositionModel(
              x: random.nextInt(columns),
              y: random.nextInt(rows),
            ),
          ),
        ),
        rover: RoverModel(
          currentPosition: PositionModel(
            x: random.nextInt(columns),
            y: random.nextInt(rows),
          ),
          currentDirection:
              DirectionType.values[random.nextInt(DirectionType.values.length)],
        ),
        commands: commandsParsed.whereNotNull().toList(),
        numberOfObstacles: numberOfObstacles,
      ),
    );
  }
}
