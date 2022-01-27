import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/model/market_place/user_profile_model.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static const _PREF_TRANSACTION_HISTORY = 'pref_transaction_history';
  static const _PREF_WALLET_LOGIN = 'pref_wallet_login';
  static const _PREF_LANGUAGE = 'pref_language';
  static const _PREF_APPLOCK = 'pref_appLock';
  static const _PREF_FACE_ID = 'pref_face_id';
  static const _PREF_FIRST_APP = 'pref_first_app';
  static const _PREF_LIST_TOKEN_SUPPORT = '';
  static const _PREF_CURRENT_BE_WALLET = 'pref_current_wallet';
  static const _PREF_USER_PROFILE = 'pref_user_info';
  static const _PREF_CURRENT_WALLET_CORE = 'pref_is_wallet_core_logged';
  static const _PREF_IS_WALLET_BE_LOGGED = 'pref_is_wallet_be_logged';
  static const _PREF_OWNER_PAWN = 'pref_owner_pawn';

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

  static String getListTokenSupport() {
    return _prefsInstance?.getString(_PREF_LIST_TOKEN_SUPPORT) ?? '';
  }

  static Future<bool> saveListTokenSupport(String value) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_LIST_TOKEN_SUPPORT, value);
  }

  static Future<bool> saveLanguage(String code) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_LANGUAGE, code);
  }

  static String getLanguage() {
    return _prefsInstance?.getString(_PREF_LANGUAGE) ?? VI_CODE;
  }

  static Future<bool> saveHistoryTransaction(String transaction) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_TRANSACTION_HISTORY, transaction);
  }

  static Future<String> getHistoryTransaction() async {
    return _prefsInstance?.getString(_PREF_TRANSACTION_HISTORY) ?? '';
  }

  static Future<bool> saveWalletLogin(String data) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_WALLET_LOGIN, data);
  }

  static String getWalletLogin() {
    return _prefsInstance?.getString(_PREF_WALLET_LOGIN) ??
        jsonLoginModelEmpty();
  }

  static Future<bool> saveOwnerPawn(String data) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_OWNER_PAWN, data);
  }

  static String getOwnerPawn() {
    return _prefsInstance?.getString(_PREF_OWNER_PAWN) ?? '';
  }

  static Future<bool> clearWalletLogin() async {
    final prefs = await _instance;
    await prefs.setString(_PREF_CURRENT_WALLET_CORE, '');
    await prefs.setString(_PREF_CURRENT_BE_WALLET, '');
    await prefs.setString(_PREF_USER_PROFILE, userProfileEmpty());
    return prefs.setString(
      _PREF_WALLET_LOGIN,
      jsonLoginModelEmpty(),
    );
  }

  static Future<bool> clearWalletBE() async {
    final prefs = await _instance;
    await prefs.setString(_PREF_CURRENT_BE_WALLET, '');
    await prefs.setString(_PREF_USER_PROFILE, userProfileEmpty());
    return prefs.setString(
      _PREF_WALLET_LOGIN,
      jsonLoginModelEmpty(),
    );
  }

  static String jsonLoginModelEmpty() {
    return loginToJson(
      LoginModel(
        accessToken: '',
        expiresIn: 0,
        refreshToken: '',
        scope: '',
        tokenType: '',
      ),
    );
  }

  Future<void> clearData() async {
    await _prefsInstance?.clear();
    return;
  }

  static Future<bool> saveUserProfile(String data) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_USER_PROFILE, data);
  }

  static String getUserProfile() {
    return _prefsInstance?.getString(_PREF_USER_PROFILE) ?? userProfileEmpty();
  }

  static String userProfileEmpty() {
    return userProfileToJson(
      UserProfileModel(
        email: '',
        createdAt: 0,
        id: 0,
        activatedAt: 0,
        address: '',
        birthday: '',
        isActive: false,
        links: [],
        name: '',
        phoneNumber: '',
        referredId: '',
        roleType: -1,
      ),
    );
  }

  static Future<bool> saveCurrentBEWallet(String walletAddress) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_CURRENT_BE_WALLET, walletAddress);
  }

  static String getCurrentBEWallet() {
    return _prefsInstance?.getString(_PREF_CURRENT_BE_WALLET) ?? '';
  }

  static Future<bool> saveCurrentWalletCore(String walletAddress) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_CURRENT_WALLET_CORE, walletAddress);
  }

  static String getCurrentWalletCore() {
    return _prefsInstance?.getString(_PREF_CURRENT_WALLET_CORE) ?? '';
  }
}
