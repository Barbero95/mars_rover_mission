import 'package:flutter/foundation.dart';
import 'package:mars_rover_mission/core/commons/domain/models/environment/environment.dart';
import 'package:mars_rover_mission/core/commons/domain/models/environment/environment_config.dart';
import 'package:mars_rover_mission/core/commons/domain/models/environment/environment_keys.dart';

class EnvironmentService {
  dynamic getValue(EnvKeys key) => EnvironmentConfig.instance.values[key.name];

  bool isDev() => (getValue(EnvKeys.environment) as Environment).isDev;
  bool isProd() => (getValue(EnvKeys.environment) as Environment).isProd;

  bool get isRelease => kReleaseMode;
  bool get isDebug => kDebugMode;
}
