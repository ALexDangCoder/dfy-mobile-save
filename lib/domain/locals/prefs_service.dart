import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static const _PREF_TOKEN_KEY = 'pref_token_key';
  static const _PREF_LANGUAGE = 'pref_language';

  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static bool isGuest() {
    return getToken().isEmpty;
  }

  static bool isLoggedIn() {
    return getToken().isNotEmpty;
  }

  static Future<bool> saveToken(String value) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_TOKEN_KEY, value);
  }

  static String getToken() {
    return _prefsInstance?.getString(_PREF_TOKEN_KEY) ?? '';
  }

  static Future<bool> saveLanguage(String code) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_LANGUAGE, code);
  }

  static String getLanguage() {
    return _prefsInstance?.getString(_PREF_LANGUAGE) ?? VI_CODE;
  }

  static Future<void> clearAuthData() async {
    await _prefsInstance?.remove(_PREF_TOKEN_KEY);
  }

  static Future<void> clearData() async {
    await _prefsInstance?.clear();
    return;
  }
}
