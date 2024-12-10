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
              Spaces.verticalS(),
              Expanded(
                child: Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final grid = _roverCPBloc.grid;
                      final rover = _roverCPBloc.rover;
                      final double cellSize = min(
                        (constraints.maxWidth - Spaces.spaceL) /
                            _roverCPBloc.grid.columns,
                        (constraints.maxHeight - Spaces.spaceL) /
                            _roverCPBloc.grid.rows,
                      );

                      return Center(
                        child: IntrinsicWidth(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('(0,0)'),
                                  const Text('N'),
                                  Text(
                                    '(${_roverCPBloc.grid.visibleColumns},0)',
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('W'),
                                  Container(
                                    margin: const EdgeInsets.all(
                                      Spaces.spaceXXS,
                                    ),
                                    width: (cellSize * grid.columns) -
                                        Spaces.spaceL,
                                    height:
                                        (cellSize * grid.rows) - Spaces.spaceL,
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
                                  const Text('E'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('(0,${_roverCPBloc.grid.visibleRows})'),
                                  const Text('S'),
                                  Text(
                                    '(${_roverCPBloc.grid.visibleColumns},${_roverCPBloc.grid.visibleRows})',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
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
