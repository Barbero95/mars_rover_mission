import 'package:flutter_template/core/commons/domain/export_domain.dart';
import 'package:flutter_template/core/commons/services/export_services.dart';
import 'package:flutter_template/features/template/export_template.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator(EnvironmentConfig environmentConfig) async {
  _registerServices(environmentConfig);

  _registerDataSources();

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
    ..registerSingletonAsync<SharedPreferencesService>(() async {
      final SharedPreferences sharedPref =
          await SharedPreferences.getInstance();
      return SharedPreferencesService(sharedPref);
    })
    ..registerSingletonAsync<TranslationsService>(
      () async {
        await TranslationsService().loadLanguageFromPrefs();
        return TranslationsService();
      },
      dependsOn: [SharedPreferencesService],
    )
    ..registerLazySingleton(NavigationService.new);
}

// // ============================== DATA SOURCES ==============================

void _registerDataSources() {
  locator.registerFactory<TemplateDataSource>(
    TemplateDataSourceImpl.new,
  );
}

// // ============================== BLOCs ==============================

void _registerBlocs() {
  locator
    ..registerLazySingleton<AppBloc>(AppBloc.new)
    ..registerFactory<TemplateBloc>(
      () => TemplateBloc(
        locator<TemplateDataSource>(),
      ),
    );
}
