import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mars_rover_mission/core/utils/modal_utils.dart';
import 'package:mars_rover_mission/features/rover_control_panel/export_rover_control_panel.dart';

class _Constants {
  static const defaultGrid = 200;
  static const defaultCommands = 'FFRRFFFRL';
  static const defaultNumberOfObstacles = 100;
}

class _Strings {
  static const invalidRowsOrColumns =
      'The number of rows and columns must be a number.';
  static const invalidCommands =
      'One or more commands could not be recognized. Please note that only the commands F, L, and R are allowed.';
  static const invalidObstaclesNumber =
      'The number of obstacles must be a number.';
  static const invalidObstacles =
      "The number of obstacles in the grid can't be equal to or greater than the total size of the grid";
}

class SetupBloc {
  late final TextEditingController _columnsTE;
  late final TextEditingController _rowsTE;
  late final TextEditingController _commandsTE;
  late final TextEditingController _numberOfObstaclesTE;
  final _formKey = GlobalKey<FormState>();

  TextEditingController get columnsTE => _columnsTE;
  TextEditingController get rowsTE => _rowsTE;
  TextEditingController get commandsTE => _commandsTE;
  TextEditingController get numberOfObstaclesTE => _numberOfObstaclesTE;
  GlobalKey<FormState> get formKey => _formKey;

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
    _numberOfObstaclesTE = TextEditingController(
      text: '${_Constants.defaultNumberOfObstacles}',
    );
  }

  void dispose() {
    _columnsTE.dispose();
    _rowsTE.dispose();
    _commandsTE.dispose();
    _numberOfObstaclesTE.dispose();
  }

  void navigateToPanelControl(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final random = Random();
      final rows = int.tryParse(_rowsTE.text.trim());
      final columns = int.tryParse(_columnsTE.text.trim());

      if (rows is! int || columns is! int) {
        ModalUtils.errorModal(
          context: context,
          description: _Strings.invalidRowsOrColumns,
        );

        return;
      }

      final commandsParsed = _commandsTE.text.trim().split('').map(
            CommandType.fromText,
          );

      if (commandsParsed.any((command) => command == null)) {
        ModalUtils.errorModal(
          context: context,
          description: _Strings.invalidCommands,
        );
        return;
      }

      final numberOfObstacles = int.tryParse(_numberOfObstaclesTE.text.trim());

      if (numberOfObstacles is! int) {
        ModalUtils.errorModal(
          context: context,
          description: _Strings.invalidObstaclesNumber,
        );
        return;
      }

      if (numberOfObstacles >= rows * columns) {
        ModalUtils.errorModal(
          context: context,
          description: _Strings.invalidObstacles,
        );
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
            currentDirection: DirectionType
                .values[random.nextInt(DirectionType.values.length)],
          ),
          commands: commandsParsed.whereNotNull().toList(),
          numberOfObstacles: numberOfObstacles,
        ),
      );
    }
  }
}
