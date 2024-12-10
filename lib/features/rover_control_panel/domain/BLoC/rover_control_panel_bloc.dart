import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mars_rover_mission/core/commons/domain/export_domain.dart';
import 'package:mars_rover_mission/features/rover_control_panel/export_rover_control_panel.dart';

class _Constants {
  static const duration = Duration(seconds: 1);
}

class RoverControlPanelBloc {
  final ValueNotifier<ScreenState> _screenState =
      ValueNotifier(ScreenState.idle);

  late final RoverModel _rover;
  late final GridModel _grid;
  late final List<CommandType> _commands;
  late final List<PositionModel> _obstacles;
  Timer? _executeCommandsTimer;

  ValueNotifier<ScreenState> get screenState => _screenState;
  RoverModel get rover => _rover;
  GridModel get grid => _grid;
  List<PositionModel> get obstacles => _obstacles;

  bool get enabledExecuteCommandsButton => _executeCommandsTimer == null;
  String get commandsString =>
      _commands.map((command) => command.name).join(',');

  void init(RoverControlPanelExtra extra) {
    _rover = extra.rover;
    _grid = extra.grid;
    _commands = extra.commands;
    _generateObstacles(extra.numberOfObstacles);
  }

  void _generateObstacles(int numberOfObstacles) {
    final random = Random();
    _obstacles = List.generate(
      numberOfObstacles,
      (_) {
        int x = random.nextInt(_grid.columns);
        int y = random.nextInt(_grid.rows);
        while (x != rover.currentPosition.x && y != rover.currentPosition.y) {
          x = random.nextInt(_grid.columns);
          y = random.nextInt(_grid.rows);
        }
        return PositionModel(
          x: x,
          y: y,
        );
      },
    );
  }

  void pauseProcessComands() {
    _screenState.value = ScreenState.loading;
    _executeCommandsTimer?.cancel();
    _executeCommandsTimer = null;
    _screenState.value = ScreenState.idle;
  }

  void processCommands(BuildContext context) {
    _executeCommandsTimer = Timer.periodic(_Constants.duration, (_) {
      _screenState.value = ScreenState.loading;
      if (_commands.isEmpty) {
        pauseProcessComands();
        return;
      }

      final command = _commands.first;

      PositionModel nextPosition = _rover.currentPosition;

      switch (command) {
        case CommandType.F:
          nextPosition = _rover.nextPosition();
        case CommandType.L:
          _rover.turnLeft();
        case CommandType.R:
          _rover.turnRight();
      }

      if (_isOutOfBounds(nextPosition)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Movimiento fuera de límites: $nextPosition')),
        );
        pauseProcessComands();
        return;
      }

      if (_obstacles.contains(nextPosition)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('¡Obstáculo detectado en $nextPosition!')),
        );
        pauseProcessComands();
        return;
      }

      _rover.moveForward(nextPosition);
      _screenState.value = ScreenState.idle;
    });
  }

  bool _isOutOfBounds(PositionModel nextPosition) {
    return nextPosition.x < 0 ||
        nextPosition.y < 0 ||
        nextPosition.x >= _grid.columns ||
        nextPosition.y >= _grid.rows;
  }

  void zoomIn() {
    _screenState.value = ScreenState.loading;
    _grid.zoomIn();
    _screenState.value = ScreenState.idle;
  }

  void zoomOut() {
    _screenState.value = ScreenState.loading;
    _grid.zoomOut();
    _screenState.value = ScreenState.idle;
  }
}
