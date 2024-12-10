import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mars_rover_mission/core/commons/services/export_services.dart';
import 'package:mars_rover_mission/features/rover_control_panel/ui/export_ui.dart';

class AppRouter {
  static GoRouter get router => _router;

  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const Scaffold(body: Center(child: Text('Error page')));

  static final GoRouter _router = GoRouter(
    navigatorKey: locator<NavigationService>().navigationKey,
    routes: <GoRoute>[
      ...RoverControlPanelRoutes.routes,
    ],
    errorBuilder: errorWidget,
  );
}
