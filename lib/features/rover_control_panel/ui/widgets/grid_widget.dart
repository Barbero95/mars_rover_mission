import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mars_rover_mission/core/commons/ui/styles/export_styles.dart';
import 'package:mars_rover_mission/features/rover_control_panel/export_rover_control_panel.dart';

class GridWidget extends StatelessWidget {
  final RoverControlPanelBloc roverCPBloc;

  const GridWidget({
    super.key,
    required this.roverCPBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final grid = roverCPBloc.grid;
            final rover = roverCPBloc.rover;
            final double cellSize = min(
              (constraints.maxWidth - Spaces.spaceL) / roverCPBloc.grid.columns,
              (constraints.maxHeight - Spaces.spaceL) / roverCPBloc.grid.rows,
            );
            final startOffset = grid.startOffset(
              rover.currentPosition,
            );

            return Center(
              child: IntrinsicWidth(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('(${startOffset.dx},${startOffset.dy})'),
                        Text(DirectionType.N.name),
                        Text(
                          '(${startOffset.dx + roverCPBloc.grid.visibleColumns - 1},${startOffset.dy})',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(DirectionType.W.name),
                        Container(
                          margin: const EdgeInsets.all(
                            Spaces.spaceXXS,
                          ),
                          width: (cellSize * grid.columns) - Spaces.spaceL,
                          height: (cellSize * grid.rows) - Spaces.spaceL,
                          child: CustomPaint(
                            painter: GridPaint(
                              rows: grid.visibleRows,
                              columns: grid.visibleColumns,
                              startOffset: startOffset,
                              obstacles: roverCPBloc.obstacles,
                              rover: rover,
                            ),
                          ),
                        ),
                        Text(DirectionType.E.name),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '(${startOffset.dx},${startOffset.dy + roverCPBloc.grid.visibleRows - 1})',
                        ),
                        Text(DirectionType.S.name),
                        Text(
                          '(${startOffset.dx + roverCPBloc.grid.visibleColumns - 1},${startOffset.dy + roverCPBloc.grid.visibleRows - 1})',
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
    );
  }
}
