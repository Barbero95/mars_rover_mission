import 'package:flutter/material.dart';
import 'package:mars_rover_mission/core/commons/domain/models/environment/environment.dart';
import 'package:mars_rover_mission/core/commons/domain/models/environment/environment_config.dart';
import 'package:mars_rover_mission/core/commons/domain/models/environment/environment_keys.dart';
import 'package:mars_rover_mission/main_shared.dart';

class _Url {
  static const String baseUrl = '';
}

Future<void> main() async {
  final Widget app = await initializeApp(
    EnvironmentConfig(
      environment: Environment.prod,
      variables: {
        EnvKeys.environment.name: Environment.prod,
        EnvKeys.baseUrl.name: _Url.baseUrl,
      },
    ),
  );
  runApp(app);
}
