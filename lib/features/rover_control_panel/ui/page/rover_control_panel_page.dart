import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mars_rover_mission/core/commons/services/export_services.dart';
import 'package:mars_rover_mission/core/commons/ui/export_ui.dart';
import 'package:mars_rover_mission/features/rover_control_panel/export_rover_control_panel.dart';
import 'package:mars_rover_mission/features/rover_control_panel/ui/widgets/header_widget.dart';

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
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final grid = _roverCPBloc.grid;
                    final rover = _roverCPBloc.rover;
                    final double cellSize = min(
                      constraints.maxWidth / _roverCPBloc.grid.columns,
                      constraints.maxHeight / _roverCPBloc.grid.rows,
                    );

                    return Center(
                      child: SizedBox(
                        width: cellSize * grid.columns,
                        height: cellSize * grid.rows,
                        child: CustomPaint(
                          painter: GridWidget(
                            rows: grid.rows,
                            columns: grid.columns,
                            startOffset: grid.startOffset(
                              rover.currentPosition,
                            ),
                            obstacles: _roverCPBloc.obstacles,
                            rover: rover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _roverCPBloc.zoomIn,
            child: const Icon(Icons.zoom_in),
          ),
          Spaces.verticalXXS(),
          FloatingActionButton(
            onPressed: _roverCPBloc.zoomOut,
            child: const Icon(Icons.zoom_out),
          ),
        ],
      ),
    );
  }
}
