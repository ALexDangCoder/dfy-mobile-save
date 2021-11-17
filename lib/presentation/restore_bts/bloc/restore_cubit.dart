import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/restore_bts/bloc/restore_state.dart';
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
      BehaviorSubject<FormType>();
  final BehaviorSubject<bool> _newPassSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _conPassSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _ckcBoxSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _validate = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _match = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _buttonSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _seedSubject = BehaviorSubject<bool>();
  bool seedField = false;
  bool newPassField = false;
  bool conPassField = false;
  bool privateField = false;
  bool ckc = true;

  /// button subject
  Stream<bool> get btnStream => _buttonSubject.stream;

  Sink<bool> get btnSink => _buttonSubject.sink;

  bool get btnValue => _buttonSubject.valueOrNull ?? false;

  /// seed phrase subject
  Stream<bool> get seedStream => _seedSubject.stream;

  Sink<bool> get seedSink => _seedSubject.sink;

  bool get seedValue => _seedSubject.valueOrNull ?? false;

  /// check validate password
  Stream<bool> get validateStream => _validate.stream;

  Stream<bool> get matchStream => _match.stream;

  Sink<bool> get validateSink => _validate.sink;

  /// compare password
  Sink<bool> get matchSink => _match.sink;

  Stream<List<String>> get listStringStream => _behaviorSubject.stream;

  Sink<List<String>> get listStringSink => _behaviorSubject.sink;

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

  /// stream of new password
  Stream<bool> get newStream => _newPassSubject.stream;

  Sink<bool> get newSink => _newPassSubject.sink;

  /// stream of confirm password
  Stream<bool> get conStream => _conPassSubject.stream;

  Sink<bool> get conSink => _conPassSubject.sink;

  /// stream of checkbox
  Stream<bool> get ckcStream => _ckcBoxSubject.stream;

  Sink<bool> get ckcSink => _ckcBoxSubject.sink;

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'importWalletCallback':
        final walletName = methodCall.arguments['walletName'];
        final walletAddress = methodCall.arguments['walletAddress'];
        wallet = Wallet(name: walletName, address: walletAddress);
        if (walletName == null || walletAddress == null) {
          emit(ErrorState());
        } else {
          emit(NavState(wallet ?? Wallet()));
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
        'password': password,
      };
      await trustWalletChannel.invokeMethod('importWallet', data);
    } on PlatformException {
      throw CommonException();
    }
  }

  /// check null seed field
  void checkSeedField(String value) {
    if (value.isNotEmpty) {
      seedField = true;
    } else {
      seedField = false;
    }
    if ((privateField || seedField) && newPassField && conPassField && ckc) {
      btnSink.add(true);
    } else {
      btnSink.add(false);
    }
  }

  /// listen check box onchange
  void checkCkcValue(value) {
    ckc = value;
    if ((privateField || seedField) && newPassField && conPassField && ckc) {
      btnSink.add(true);
    } else {
      btnSink.add(false);
    }
  }

  /// check null new password
  void checkNewPassField(String value) {
    if (value.isNotEmpty) {
      newPassField = true;
    } else {
      newPassField = false;
    }
    if ((privateField || seedField) && newPassField && conPassField && ckc) {
      btnSink.add(true);
    } else {
      btnSink.add(false);
    }
  }

  /// check null confirm password
  void checkConPassField(String value) {
    if (value.isNotEmpty) {
      conPassField = true;
    } else {
      conPassField = false;
    }
    if ((privateField || seedField) && newPassField && conPassField && ckc) {
      btnSink.add(true);
    } else {
      btnSink.add(false);
    }
  }

  /// check null private key
  void checkPrivateField(String value) {
    if (value.isNotEmpty) {
      privateField = true;
    } else {
      privateField = false;
    }
    if ((privateField || seedField) && newPassField && conPassField && ckc) {
      btnSink.add(true);
    } else {
      btnSink.add(false);
    }
  }

  /// check validate of seed phrase
  void checkSeedPhrase(String strArray) {
    final int len = strArray.split(' ').length;
    if (len == 12 || len == 15 || len == 18 || len == 21 || len == 24) {
      seedSink.add(false);
    } else {
      seedSink.add(true);
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
