import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static const _PREF_TRANSACTION_HISTORY = 'pref_transaction_history';
  static const _PREF_LANGUAGE = 'pref_language';
  static const _PREF_APPLOCK = 'pref_appLock';
  static const _PREF_FACE_ID = 'pref_face_id';
  static const _PREF_FIRST_APP = 'pref_first_app';

  final storage = const FlutterSecureStorage();
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();

  // call this method form iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
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
    return prefs.setString(_PREF_FACE_ID, value);
  }

  static String getFaceIDConfig() {
    return _prefsInstance?.getString(_PREF_FACE_ID) ?? 'false';
  }

  static String getFirstAppConfig() {
    return _prefsInstance?.getString(_PREF_FIRST_APP) ?? 'true';
  }

  static Future<bool> saveFirstAppConfig(String value) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_FIRST_APP, value);
  }

  static Future<bool> saveLanguage(String code) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_LANGUAGE, code);
  }

  static String getLanguage() {
    return _prefsInstance?.getString(_PREF_LANGUAGE) ?? VI_CODE;
  }

  Future<void> saveHistoryTransaction(String token) async {
    await storage.write(key: _PREF_TRANSACTION_HISTORY, value: token);
  }

  Future<String> getHistoryTransaction() async {
    return await storage.read(key: _PREF_TRANSACTION_HISTORY) ?? '';
  }

  Future<void> clearData() async {
    await _prefsInstance?.clear();
    await storage.delete(key: _PREF_TRANSACTION_HISTORY);
    return;
  }
}
