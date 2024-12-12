import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mars_rover_mission/core/commons/domain/export_domain.dart';
import 'package:mars_rover_mission/core/commons/services/export_services.dart';
import 'package:mars_rover_mission/core/commons/ui/styles/export_styles.dart';

Future<Widget> initializeApp(
  EnvironmentConfig environmentConfig,
) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  await setupLocator(environmentConfig);
  return const App();
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: locator<AppBloc>().themeModel,
      builder: (context, themeModel, child) {
        return MaterialApp.router(
          title: locator<EnvironmentService>().appName,
          themeMode: themeModel.themeMode,
          theme: AppTheme.lightTheme(themeModel),
          darkTheme: AppTheme.darkTheme(themeModel),
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: locator<EnvironmentService>().isDebug,
        );
      },
    );
  }
}
