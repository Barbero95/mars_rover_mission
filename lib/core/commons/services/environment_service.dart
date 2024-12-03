import 'package:flutter/foundation.dart';
import 'package:flutter_template/core/commons/domain/models/environment/environment.dart';
import 'package:flutter_template/core/commons/domain/models/environment/environment_config.dart';
import 'package:flutter_template/core/commons/domain/models/environment/environment_keys.dart';

class EnvironmentService {
  dynamic getValue(EnvKeys key) => EnvironmentConfig.instance.values[key.name];

  bool isDev() => (getValue(EnvKeys.environment) as Environment).isDev;
  bool isProd() => (getValue(EnvKeys.environment) as Environment).isProd;

  bool get isRelease => kReleaseMode;
  bool get isDebug => kDebugMode;
}
