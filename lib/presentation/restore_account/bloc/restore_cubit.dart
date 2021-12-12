import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/restore_account/bloc/restore_state.dart';
import 'package:Dfy/utils/extensions/validator.dart';
import 'package:Dfy/widgets/form/item_form.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class RestoreCubit extends Cubit<RestoreState> {
  Wallet? wallet = Wallet();

  RestoreCubit() : super(RestoreInitial());
  final BehaviorSubject<List<String>> _behaviorSubject =
      BehaviorSubject<List<String>>();
  final BehaviorSubject<String> _stringSubject =
      BehaviorSubject.seeded(S.current.seed_phrase);
  final BehaviorSubject<bool> _boolSubject = BehaviorSubject<bool>();
  final BehaviorSubject<FormType> _formTypeSubject =
      BehaviorSubject.seeded(FormType.PASS_PHRASE);
  final BehaviorSubject<bool> _newPassSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _conPassSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _ckcBoxSubject = BehaviorSubject.seeded(true);
  final BehaviorSubject<bool> _buttonSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _seedSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _validate = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<String> _txtWarningNewPW =
      BehaviorSubject<String>.seeded('');
  final BehaviorSubject<bool> _match = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<String> _txtWarningConfirmPW =
      BehaviorSubject<String>.seeded('');
  final BehaviorSubject<String> _txtWarningSeed =
      BehaviorSubject<String>.seeded('');

  /// Huy
  bool newPasswordField = false;
  bool confirmPasswordField = false;
  bool seedField = false;
  bool privateField = false;
  bool checkBoxValue = false;
  String newPassword = '';

  /// button subject
  Stream<bool> get btnStream => _buttonSubject.stream;

  Sink<bool> get btnSink => _buttonSubject.sink;

  bool get btnValue => _buttonSubject.valueOrNull ?? false;

  /// compare password
  Stream<List<String>> get listStringStream => _behaviorSubject.stream;

  Sink<List<String>> get listStringSink => _behaviorSubject.sink;

  ///
  Stream<bool> get seedStream => _seedSubject.stream;

  Sink<bool> get seedSink => _seedSubject.sink;

  bool get seedValue => _seedSubject.valueOrNull ?? false;

  /// select string
  String get strValue => _stringSubject.value;

  Stream<String> get stringStream => _stringSubject.stream;

  Sink<String> get stringSink => _stringSubject.sink;

  /// show or hide password
  Stream<bool> get boolStream => _boolSubject.stream;

  Sink<bool> get boolSink => _boolSubject.sink;

  /// select private or seed phrase form
  Stream<FormType> get typeStream => _formTypeSubject.stream;

  Sink<FormType> get typeSink => _formTypeSubject.sink;

  FormType get type => _formTypeSubject.value;

  /// stream of new password
  Stream<bool> get newStream => _newPassSubject.stream;

  Sink<bool> get newSink => _newPassSubject.sink;

  /// stream of confirm password
  Stream<bool> get conStream => _conPassSubject.stream;

  Sink<bool> get conSink => _conPassSubject.sink;

  /// stream of checkbox
  Stream<bool> get ckcStream => _ckcBoxSubject.stream;

  Sink<bool> get ckcSink => _ckcBoxSubject.sink;

  bool get ckcValue => _ckcBoxSubject.value;

  ///
  Stream<bool> get validateStream => _validate.stream;

  Sink<bool> get validateSink => _validate.sink;

  Sink<String> get txtWarningNewPWSink => _txtWarningNewPW.sink;

  Stream<String> get txtWarningNewPWStream => _txtWarningNewPW.stream;

  Stream<String> get txtWarningConfirmPWStream => _txtWarningConfirmPW.stream;

  Sink<String> get txtWarningConfirmPWSink => _txtWarningConfirmPW.sink;

  Stream<bool> get matchStream => _match.stream;

  Sink<bool> get matchSink => _match.sink;

  Sink<String> get txtWarningSeedSink => _txtWarningSeed.sink;

  Stream<String> get txtWarningSeedStream => _txtWarningSeed.stream;

  ///
  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'importWalletCallback':
        final walletName = methodCall.arguments['walletName'];
        final walletAddress = methodCall.arguments['walletAddress'];
        //message = methodCall.arguments['message'];
        final code = methodCall.arguments['code'];
        wallet = Wallet(name: walletName, address: walletAddress);
        if (walletName == null || walletAddress == null || code == 400) {
          emit(ErrorState());
        } else {
          emit(NavState());
        }
        break;
      default:
        break;
    }
  }

  Future<void> importWallet({
    required String type,
    required String content,
    String? password,
  }) async {
    try {
      final data = {
        'type': type,
        'content': content,
      };
      await trustWalletChannel.invokeMethod('importWallet', data);
    } on PlatformException {
      throw CommonException();
    }
  }

  /// check validation of password
  void isValidate(String value) {
    if (Validator.validateStructure(value)) {
      validateSink.add(false);
    } else {
      validateSink.add(true);
    }
  }

  /// check match password
  void isMatchPW({required String password, required String confirmPW}) {
    if (password == confirmPW) {
      matchSink.add(false);
    } else {
      matchSink.add(true);
    }
  }

  bool isMatch(String value, String confirmValue) {
    if (Validator.validateStructure(value) && (value == confirmValue)) {
      return true;
    } else {
      return false;
    }
  }

  void showTxtWarningNewPW(String value) {
    if ((value.isNotEmpty && value.length < 8) ||
        (value.isNotEmpty && value.length > 15)) {
      newPasswordField = false;
      validateSink.add(true);
      txtWarningNewPWSink.add(S.current.warn_pw_8_15);
      btnSink.add(false);
      ckcSink.add(false);
    } else if (value.isEmpty) {
      newPasswordField = false;
      validateSink.add(true);
      txtWarningNewPWSink.add(S.current.password_is_required);
      btnSink.add(false);
      ckcSink.add(false);
    } else if (!Validator.validateStructure(value)) {
      newPasswordField = false;
      validateSink.add(true);
      txtWarningNewPWSink.add(S.current.warn_pw_validate);
      btnSink.add(false);
      ckcSink.add(false);
    } else {
      validateSink.add(false);
      newPasswordField = true;
      if ((seedField || privateField) &&
          confirmPasswordField &&
          newPasswordField &&
          checkBoxValue) {
        btnSink.add(true);
      }
    }
  }

  void showTxtWarningSeed(String value, FormType type) {
    if (type == FormType.PASS_PHRASE) {
      if (value.isEmpty) {
        seedField = false;
        seedSink.add(true);
        txtWarningSeedSink.add(S.current.seed_required);
        btnSink.add(false);
        ckcSink.add(false);
      } else {
        final int len = value.split(' ').length;
        bool flag;
        if (value.contains('  ') || value[value.length - 1] == ' ') {
          flag = false;
        } else {
          flag = true;
        }
        if ((len == 12 || len == 15 || len == 18 || len == 21 || len == 24) &&
            flag == true) {
          seedSink.add(false);
          seedField = true;
          if ((seedField || privateField) &&
              confirmPasswordField &&
              newPasswordField &&
              checkBoxValue) {
            btnSink.add(true);
          }
        } else {
          seedField = false;
          seedSink.add(true);
          txtWarningSeedSink.add(S.current.warning_seed);
          btnSink.add(false);
          ckcSink.add(false);
        }
      }
    } else {
      if (value.isEmpty) {
        privateField = false;
        seedSink.add(true);
        txtWarningSeedSink.add(S.current.private_required);
        btnSink.add(false);
        ckcSink.add(false);
      } else {
        final int len = value.length;
        if (len == 64 && !value.contains(' ')) {
          privateField = true;
          seedSink.add(false);
          if ((seedField || privateField) &&
              confirmPasswordField &&
              newPasswordField &&
              checkBoxValue) {
            btnSink.add(true);
          }
        } else {
          privateField = false;
          seedSink.add(true);
          txtWarningSeedSink.add(S.current.private_warning);
          btnSink.add(false);
          ckcSink.add(false);
        }
      }
    }
  }

  void showTxtWarningConfirmPW(String value, {required String newPW}) {
    if (value != newPW) {
      confirmPasswordField = false;
      matchSink.add(true);
      txtWarningConfirmPWSink.add(S.current.not_match);
      btnSink.add(false);
      ckcSink.add(false);
    } else if (value.isEmpty) {
      confirmPasswordField = false;
      matchSink.add(true);
      txtWarningConfirmPWSink.add(S.current.password_is_required);
      btnSink.add(false);
      ckcSink.add(false);
    } else {
      matchSink.add(false);
      confirmPasswordField = true;
      if ((seedField || privateField) &&
          confirmPasswordField &&
          newPasswordField &&
          checkBoxValue) {
        btnSink.add(true);
      }
    }
  }

  void checkCkcValue(value) {
    checkBoxValue = value;
    if ((seedField || confirmPasswordField) &&
        confirmPasswordField &&
        newPasswordField &&
        checkBoxValue) {
      btnSink.add(true);
    } else {
      btnSink.add(false);
    }
  }

  /// check validate of seed phrase
  bool validateAll() {
    if ((seedField || privateField) &&
        confirmPasswordField &&
        newPasswordField &&
        ckcValue) {
      return true;
    } else {
      return false;
    }
  }
  ///setFirstTime
  Future<void> setFirstTime() async {
    await PrefsService.saveFirstAppConfig('false');
  }
  void dispose() {
    _behaviorSubject.close();
    _stringSubject.close();
    _boolSubject.close();
    _formTypeSubject.close();
    _newPassSubject.close();
    _conPassSubject.close();
    _seedSubject.close();
    _ckcBoxSubject.close();
    _conPassSubject.close();
    _newPassSubject.close();
    _buttonSubject.close();

    super.close();
  }
}
