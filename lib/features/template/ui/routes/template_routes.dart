import 'package:flutter/material.dart';
import 'package:flutter_template/features/template/export_template.dart';
import 'package:go_router/go_router.dart';

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
