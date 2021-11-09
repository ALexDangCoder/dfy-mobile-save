import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static const _PREF_TOKEN_KEY = 'pref_token_key';
  static const _PREF_LANGUAGE = 'pref_language';
  static const _PREF_APPLOCK = 'pref_appLock';
  static const _PREF_FACEID = 'pref_face_id';

  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();

  // call this method form iniState() function of mainApp().
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
  static Future<bool> saveAppLockConfig(String value) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_APPLOCK, value);
  }
  static String getAppLockConfig() {
    return _prefsInstance?.getString(_PREF_APPLOCK) ?? 'true';
  }
  static Future<bool> saveFaceIDConfig(String value) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_APPLOCK, value);

  }
  static String getFaceIDConfig() {
    return _prefsInstance?.getString(_PREF_APPLOCK) ?? 'false';
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
