import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mars_rover_mission/core/commons/ui/styles/export_styles.dart';
import 'package:mars_rover_mission/features/rover_control_panel/export_rover_control_panel.dart';

class _Strings {
  static const errorLoadGrid =
      "Sorry, but the proportions of the grid are too unbalanced, and the panel can't be displayed correctly. Please try a different configuration.";
}

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
              (constraints.maxWidth - Spaces.spaceL) / grid.columns,
              (constraints.maxHeight - Spaces.spaceL) / grid.rows,
            );
            final (startOffsetX, startOffsetY, startOffset) = grid.startOffset(
              rover.currentPosition,
            );

            return Center(
              child: IntrinsicWidth(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if ((cellSize * grid.columns) - Spaces.spaceL > 0 &&
                        (cellSize * grid.rows) - Spaces.spaceL > 0) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('($startOffsetX,$startOffsetY)'),
                          Text(DirectionType.N.name),
                          Text(
                            '(${startOffsetX + grid.visibleColumns - 1},$startOffsetY)',
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
                            '($startOffsetX,${startOffsetY + grid.visibleRows - 1})',
                          ),
                          Text(DirectionType.S.name),
                          Text(
                            '(${startOffsetX + grid.visibleColumns - 1},${startOffsetY + grid.visibleRows - 1})',
                          ),
                        ],
                      ),
                    ] else
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spaces.spaceXXS,
                        ),
                        child: Text(
                          _Strings.errorLoadGrid,
                          style: CustomTextStyle.paragraphMbold.copyWith(
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
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
