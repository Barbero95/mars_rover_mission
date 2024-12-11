import 'package:flutter/material.dart';
import 'package:mars_rover_mission/core/commons/ui/export_ui.dart';
import 'package:mars_rover_mission/core/utils/modal_utils.dart';
import 'package:mars_rover_mission/features/rover_control_panel/export_rover_control_panel.dart';
import 'package:sprintf/sprintf.dart';

class _Strings {
  static const commandsLabel = 'Commands';
  static const start = 'Start';
  static const pause = 'Pause';
  static const edit = 'Edit';
  static const roverPositionLabel = 'Rover position';
  static const roverDirectionLabel = 'Rover direction';
  static const gridLabel = 'Grid: %s, ZoomGrid: %s';
}

class HeaderWidget extends StatelessWidget {
  final RoverControlPanelBloc roverCPBloc;

  const HeaderWidget({
    super.key,
    required this.roverCPBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          runSpacing: Spaces.spaceXXS,
          spacing: Spaces.spaceXXS,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text('${_Strings.commandsLabel}: ${roverCPBloc.commandsJoin}'),
            FilledButton(
              onPressed: () => ModalUtils.editCommandsModal(
                context: context,
                commands: roverCPBloc.commandsString,
                onPressedPrimaryBtn: (newCommands) => roverCPBloc.editCommands(
                  context: context,
                  newCommands: newCommands,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.edit),
                  Spaces.horizontalXXS(),
                  const Text(
                    _Strings.edit,
                  ),
                ],
              ),
            ),
            FilledButton(
              onPressed: () => roverCPBloc.enabledExecuteCommandsButton
                  ? roverCPBloc.processCommands(context)
                  : roverCPBloc.pauseProcessComands(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    roverCPBloc.enabledExecuteCommandsButton
                        ? Icons.play_arrow
                        : Icons.pause,
                  ),
                  Spaces.horizontalXXS(),
                  Text(
                    roverCPBloc.enabledExecuteCommandsButton
                        ? _Strings.start
                        : _Strings.pause,
                  ),
                ],
              ),
            ),
          ],
        ),
        Spaces.verticalXXXS(),
        Text(
          '${_Strings.roverPositionLabel}: ${roverCPBloc.rover.currentPosition}',
        ),
        Spaces.verticalXXXS(),
        Text(
          '${_Strings.roverDirectionLabel}: ${roverCPBloc.rover.currentDirection.name}',
        ),
        Spaces.verticalXXXS(),
        Text(
          sprintf(
            _Strings.gridLabel,
            [
              '(${roverCPBloc.grid.columns},${roverCPBloc.grid.rows})',
              '(${roverCPBloc.grid.visibleColumns},${roverCPBloc.grid.visibleRows})',
            ],
          ),
        ),
      ],
    );
  }
}
