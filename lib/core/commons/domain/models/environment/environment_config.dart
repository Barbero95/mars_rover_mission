import 'package:mars_rover_mission/core/commons/domain/models/environment/environment.dart';

class EnvironmentConfig {
  /// Type of flavor
  final Environment? environment;

  /// Variables are dynamic
  final Map<String, dynamic> values;

  /// Factory constructor
  factory EnvironmentConfig({
    Environment? environment,
    Map<String, dynamic> variables = const {},
  }) {
    _instance = EnvironmentConfig._internal(
      environment,
      variables,
    );

    return _instance!;
  }

  /// Private constructor
  EnvironmentConfig._internal(
    this.environment,
    this.values,
  );

  /// Internal instance of EnvironmentConfig
  static EnvironmentConfig? _instance;

  /// Instance of EnvironmentConfig
  // ignore: prefer_constructors_over_static_methods
  static EnvironmentConfig get instance {
    _instance ??= EnvironmentConfig();

    return _instance!;
  }
}
