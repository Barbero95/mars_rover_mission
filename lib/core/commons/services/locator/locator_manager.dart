import 'package:get_it/get_it.dart';
import 'package:mars_rover_mission/core/commons/domain/export_domain.dart';
import 'package:mars_rover_mission/core/commons/services/export_services.dart';
import 'package:mars_rover_mission/features/rover_control_panel/export_rover_control_panel.dart';
import 'package:mars_rover_mission/features/setup/domain/export_domain.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator(EnvironmentConfig environmentConfig) async {
  _registerServices(environmentConfig);

  _registerBlocs();

  await locator.allReady();
}

// // ============================== SERVICES ==============================

void _registerServices(EnvironmentConfig environmentConfig) {
  locator
    ..registerSingletonAsync<EnvironmentService>(() async {
      final EnvironmentService appConfigservice = EnvironmentService();
      return appConfigservice;
    })
    ..registerLazySingleton(NavigationService.new);
}

// // ============================== BLOCs ==============================

void _registerBlocs() {
  locator
    ..registerLazySingleton<AppBloc>(AppBloc.new)
    ..registerFactory<SetupBloc>(SetupBloc.new)
    ..registerFactory<RoverControlPanelBloc>(RoverControlPanelBloc.new);
}
