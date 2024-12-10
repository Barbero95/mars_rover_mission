import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mars_rover_mission/features/setup/ui/export_ui.dart';

class SetupRoutes {
  SetupRoutes._();

  static const setup = '/';

  static Widget _setupRouteBuilder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const SetupPage();

  static List<GoRoute> routes = [
    GoRoute(
      path: setup,
      builder: _setupRouteBuilder,
    ),
  ];
}
