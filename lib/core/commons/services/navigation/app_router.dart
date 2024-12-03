import 'package:flutter/material.dart';
import 'package:flutter_template/core/commons/services/export_services.dart';
import 'package:flutter_template/features/template/export_template.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter get router => _router;

  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const Scaffold(body: Center(child: Text('Error page')));

  static final GoRouter _router = GoRouter(
    navigatorKey: locator<NavigationService>().navigationKey,
    routes: <GoRoute>[
      ...TemplateRoutes.routes,
    ],
    errorBuilder: errorWidget,
  );
}
