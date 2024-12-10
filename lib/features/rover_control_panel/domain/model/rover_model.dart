// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mars_rover_mission/features/rover_control_panel/domain/model/export_model.dart';

class RoverModel {
  PositionModel currentPosition;
  DirectionType currentDirection;

  RoverModel({
    required this.currentPosition,
    required this.currentDirection,
  });

  @override
  String toString() =>
      'RoverModel(currentPosition: $currentPosition, currentDirection: $currentDirection)';

  PositionModel nextPosition() {
    return PositionModel(
      x: switch (currentDirection) {
        DirectionType.E => currentPosition.x + 1,
        DirectionType.W => currentPosition.x - 1,
        _ => currentPosition.x,
      },
      y: switch (currentDirection) {
        DirectionType.N => currentPosition.y - 1,
        DirectionType.S => currentPosition.y + 1,
        _ => currentPosition.y,
      },
    );
  }

  void moveForward(PositionModel nextPosition) {
    currentPosition
      ..x = nextPosition.x
      ..y = nextPosition.y;
  }

  void turnLeft() {
    currentDirection = switch (currentDirection) {
      DirectionType.N => DirectionType.W,
      DirectionType.W => DirectionType.S,
      DirectionType.S => DirectionType.E,
      DirectionType.E => DirectionType.N,
    };
  }

  void turnRight() {
    currentDirection = switch (currentDirection) {
      DirectionType.N => DirectionType.E,
      DirectionType.E => DirectionType.S,
      DirectionType.S => DirectionType.W,
      DirectionType.W => DirectionType.N,
    };
  }

  bool isOutOfBounds({
    required int columns,
    required int rows,
  }) {
    return currentPosition.x < 0 ||
        currentPosition.y < 0 ||
        currentPosition.x >= columns ||
        currentPosition.y >= rows;
  }
}
