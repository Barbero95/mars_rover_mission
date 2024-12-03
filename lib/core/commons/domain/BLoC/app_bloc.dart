import 'package:flutter/material.dart';
import 'package:flutter_template/core/commons/domain/models/export_models.dart';

class AppBloc {
  late final ValueNotifier<ThemeModel> _themeModel = ValueNotifier(
    ThemeModel(
      useMaterial3: true,
      themeMode: ThemeMode.light,
    ),
  );

  ValueNotifier<ThemeModel> get themeModel => _themeModel;

  bool useLightMode(
    BuildContext context,
  ) {
    switch (themeModel.value.themeMode) {
      case ThemeMode.system:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  void updateThemeMode(ThemeMode themeMode) =>
      _themeModel.value = themeModel.value.copyWith(themeMode: themeMode);

  void updateUseMaterial3() => _themeModel.value =
      themeModel.value.copyWith(useMaterial3: !_themeModel.value.useMaterial3);
}
