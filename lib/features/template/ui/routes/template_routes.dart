import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mars_rover_mission/features/template/export_template.dart';

class TemplateRoutes {
  TemplateRoutes._();

  static const template = '/';

  static Widget _templateRouteBuilder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const TemplatePage();

  static List<GoRoute> routes = [
    GoRoute(
      path: template,
      builder: _templateRouteBuilder,
    ),
  ];
}
