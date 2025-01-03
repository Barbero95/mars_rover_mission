import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mars_rover_mission/core/commons/domain/export_domain.dart';
import 'package:mars_rover_mission/core/utils/modal_utils.dart';
import 'package:mars_rover_mission/features/rover_control_panel/export_rover_control_panel.dart';
import 'package:sprintf/sprintf.dart';

class _Constants {
  static const duration = Duration(seconds: 1);
}

class _Strings {
  static const outOfBoundsError = 'Out-of-bounds movement:';
  static const obstacleDetectError =
      'Obstacle detected at %s.\nPlease enter the new commands to continue.';
  static const editCommandsError =
      'Sorry. An error occurred while processing the new commands. Please try again.';
  static const waitingNewCommandsTitle = 'Awaiting Commands';
  static const waitingNewCommandsContent =
      'Rover is ready and waiting for new instructions.';
  static const noMoreZoomIn = "Can't zoom in any further";
  static const noMoreZoomOut = "Can't zoom out any further";
  static const noMoreMaxZoomIn = 'Already at maximum zoom in';
  static const noMoreMaxZoomOut = 'Already at maximum zoom out';
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
  String get commandsString => _commands.map((command) => command.name).join();
  String get commandsJoin => _commands.map((command) => command.name).join(',');

  void init(RoverControlPanelExtra extra) {
    _rover = extra.rover;
    _grid = extra.grid;
    _commands = extra.commands;
    _generateObstacles(extra.numberOfObstacles);
  }

  void _generateObstacles(int numberOfObstacles) {
    final random = Random();
    final Set<PositionModel> obstacles = {};
    while (obstacles.length < numberOfObstacles) {
      final newObstacle = PositionModel(
        x: random.nextInt(_grid.columns),
        y: random.nextInt(_grid.rows),
      );

      if (newObstacle != rover.currentPosition) {
        obstacles.add(newObstacle);
      }
    }
    _obstacles = obstacles.toList();
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
        ModalUtils.errorModal(
          context: context,
          description: '${_Strings.outOfBoundsError} $nextPosition',
        );
        pauseProcessComands();
        return;
      }

      if (_obstacles.contains(nextPosition)) {
        ModalUtils.errorModal(
          context: context,
          description: sprintf(
            _Strings.obstacleDetectError,
            [
              nextPosition.toString(),
            ],
          ),
        );
        pauseProcessComands();
        return;
      }

      _commands.removeAt(0);
      _rover.moveForward(nextPosition);
      _screenState.value = ScreenState.idle;
      if (_commands.isEmpty) {
        ModalUtils.basicModal(
          context: context,
          title: _Strings.waitingNewCommandsTitle,
          content: const Text(
            _Strings.waitingNewCommandsContent,
          ),
        );
      }
    });
  }

  bool _isOutOfBounds(PositionModel nextPosition) {
    return nextPosition.x < 0 ||
        nextPosition.y < 0 ||
        nextPosition.x >= _grid.columns ||
        nextPosition.y >= _grid.rows;
  }

  void zoomIn(BuildContext context) {
    _screenState.value = ScreenState.loading;
    final success = _grid.zoomIn();
    if (!success) {
      ModalUtils.errorModal(
        context: context,
        description: _Strings.noMoreZoomIn,
      );
    }
    _screenState.value = ScreenState.idle;
  }

  void zoomOut(BuildContext context) {
    _screenState.value = ScreenState.loading;
    final success = _grid.zoomOut();
    if (!success) {
      ModalUtils.errorModal(
        context: context,
        description: _Strings.noMoreZoomOut,
      );
    }
    _screenState.value = ScreenState.idle;
  }

  void maxZoomIn(BuildContext context) {
    _screenState.value = ScreenState.loading;
    final success = _grid.maxZoomIn();
    if (!success) {
      ModalUtils.errorModal(
        context: context,
        description: _Strings.noMoreMaxZoomIn,
      );
    }
    _screenState.value = ScreenState.idle;
  }

  void maxZoomOut(BuildContext context) {
    _screenState.value = ScreenState.loading;
    final success = _grid.maxZoomOut();
    if (!success) {
      ModalUtils.errorModal(
        context: context,
        description: _Strings.noMoreMaxZoomOut,
      );
    }
    _screenState.value = ScreenState.idle;
  }

  void editCommands({
    required BuildContext context,
    required String newCommands,
  }) {
    _screenState.value = ScreenState.loading;
    final newCommandsParsed = newCommands.trim().split('').map(
          CommandType.fromText,
        );
    if (newCommandsParsed.any((command) => command == null)) {
      ModalUtils.errorModal(
        context: context,
        description: _Strings.editCommandsError,
      );
    } else {
      _commands
        ..clear()
        ..addAll(
          newCommandsParsed.whereNotNull().toList(),
        );
    }
    _screenState.value = ScreenState.idle;
  }
}
