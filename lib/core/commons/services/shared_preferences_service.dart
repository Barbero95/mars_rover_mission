import 'package:shared_preferences/shared_preferences.dart';

class _Keys {
  static String onBoardingShown = 'onBoardingShown';
  static String refreskToken = 'refreskToken';
  static String accessToken = 'accessToken';
  static String openAppFirstTime = 'openAppFirstTime';
  static String showDialogNotificationExplanation =
      'showDialogNotificationExplanation';
}

class SharedPreferencesService {
  SharedPreferencesService(this._preferences);

  final SharedPreferences _preferences;

  bool isFirstTimeOpenApp() =>
      _preferences.getBool(_Keys.openAppFirstTime) ?? true;

  void setIsFirstTimeOpenApp(bool isFirstTime) =>
      _preferences.setBool(_Keys.openAppFirstTime, isFirstTime);

  Future<void> setOnBoardingSeen(bool value) async =>
      _preferences.setBool(_Keys.onBoardingShown, value);

  bool getOnBoardingSeen() =>
      _preferences.getBool(_Keys.onBoardingShown) ?? false;

  String? getRefreshToken() => _preferences.getString(_Keys.refreskToken);

  Future<void> setRefreshToken(String refreskToken) async =>
      _preferences.setString(_Keys.refreskToken, refreskToken);

  String? getAccessToken() => _preferences.getString(_Keys.accessToken);

  Future<void> setAccessToken(String accessToken) async =>
      _preferences.setString(_Keys.accessToken, accessToken);

  bool getShowDialogNotificationExplanation() =>
      _preferences.getBool(_Keys.showDialogNotificationExplanation) ?? true;

  Future<void> setShowDialogNotificationExplanation(
    bool showDialogNotificationExplanation,
  ) async =>
      _preferences.setBool(
        _Keys.showDialogNotificationExplanation,
        showDialogNotificationExplanation,
      );
}
