import 'package:flutter/material.dart';
import 'package:mars_rover_mission/core/commons/services/export_services.dart';
import 'package:mars_rover_mission/core/commons/ui/export_ui.dart';
import 'package:mars_rover_mission/features/rover_control_panel/export_rover_control_panel.dart';

class RoverControlPanelPage extends StatefulWidget {
  final RoverControlPanelExtra extra;

  const RoverControlPanelPage({
    super.key,
    required this.extra,
  });

  @override
  State<RoverControlPanelPage> createState() => _RoverControlPanelPageState();
}

class _RoverControlPanelPageState extends State<RoverControlPanelPage> {
  late final RoverControlPanelBloc _roverCPBloc;

  @override
  void initState() {
    super.initState();
    _roverCPBloc = locator<RoverControlPanelBloc>()
      ..init(
        widget.extra,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rover Control Panel'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _roverCPBloc.screenState,
        builder: (context, screenState, _) {
          if (screenState.isError) {
            return const Center(
              child: Text(
                'Ups! We have lost connection with the rover',
              ),
            );
          }

          return Column(
            children: [
              HeaderWidget(
                roverCPBloc: _roverCPBloc,
              ),
              Spaces.verticalS(),
              GridWidget(
                roverCPBloc: _roverCPBloc,
              ),
              Spaces.verticalS(),
            ],
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'zoomIn',
            onPressed: _roverCPBloc.zoomIn,
            child: const Icon(Icons.zoom_in),
          ),
          Spaces.horizontalXXS(),
          FloatingActionButton(
            heroTag: 'zoomOut',
            onPressed: _roverCPBloc.zoomOut,
            child: const Icon(Icons.zoom_out),
          ),
        ],
      ),
    );
  }
}
