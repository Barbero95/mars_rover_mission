import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/core/commons/domain/export_domain.dart';
import 'package:flutter_template/core/commons/services/export_services.dart';
import 'package:flutter_template/core/commons/ui/styles/export_styles.dart';

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
        return ValueListenableBuilder<Locale>(
          valueListenable: locator<TranslationsService>().locale,
          builder: (BuildContext context, Locale currentLocale, Widget? child) {
            return MaterialApp.router(
              themeMode: themeModel.themeMode,
              theme: AppTheme.lightTheme(themeModel),
              darkTheme: AppTheme.darkTheme(themeModel),
              locale: currentLocale,
              localeListResolutionCallback: (
                List<Locale>? locales,
                Iterable<Locale> supportedLocales,
              ) {
                return null;
              },
              localeResolutionCallback:
                  (Locale? locale, Iterable<Locale> supportedLocales) {
                return null;
              },
              routerConfig: AppRouter.router,
              localizationsDelegates: const [
                Translation.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: Translation.delegate.supportedLocales,
              debugShowCheckedModeBanner: locator<EnvironmentService>().isDebug,
            );
          },
        );
      },
    );
  }
}
