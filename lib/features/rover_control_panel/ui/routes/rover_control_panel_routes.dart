import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mars_rover_mission/features/rover_control_panel/export_rover_control_panel.dart';

class RoverControlPanelRoutes {
  RoverControlPanelRoutes._();

  static const roverControlPanel = '/';

  static Widget _roverControlPanelRouteBuilder(
    BuildContext context,
    GoRouterState state,
  ) =>
      RoverControlPanelPage(
        extra: state.extra! as RoverControlPanelExtra,
      );

  static List<GoRoute> routes = [
    GoRoute(
      path: roverControlPanel,
      builder: _roverControlPanelRouteBuilder,
    ),
  ];
}
