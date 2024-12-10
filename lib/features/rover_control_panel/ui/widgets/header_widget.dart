import 'package:flutter/material.dart';
import 'package:mars_rover_mission/core/commons/ui/export_ui.dart';
import 'package:mars_rover_mission/features/rover_control_panel/export_rover_control_panel.dart';

class HeaderWidget extends StatelessWidget {
  final RoverControlPanelBloc roverCPBloc;

  const HeaderWidget({
    super.key,
    required this.roverCPBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: Spaces.spaceXXS,
      spacing: Spaces.spaceXXS,
      children: [
        Text('Commands: ${roverCPBloc.commandsString}'),
        ElevatedButton(
          onPressed: () => roverCPBloc.enabledExecuteCommandsButton
              ? roverCPBloc.processCommands(context)
              : roverCPBloc.pauseProcessComands(),
          child: Text(
            roverCPBloc.enabledExecuteCommandsButton ? 'Start' : 'Pause',
          ),
        ),
      ],
    );
  }
}
