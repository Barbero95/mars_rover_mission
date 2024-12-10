import 'package:mars_rover_mission/features/rover_control_panel/export_rover_control_panel.dart';

class RoverControlPanelExtra {
  final GridModel grid;
  final RoverModel rover;
  final List<CommandType> commands;
  final int numberOfObstacles;

  RoverControlPanelExtra({
    required this.grid,
    required this.rover,
    required this.commands,
    required this.numberOfObstacles,
  });
}
