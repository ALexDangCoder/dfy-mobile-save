import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/utils/extensions/validator.dart';
import 'package:Dfy/widgets/form/item_form.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'package:Dfy/presentation/import_account/bloc/import_state.dart';

class ImportCubit extends Cubit<ImportState> {
  Wallet? wallet = Wallet();

  bool haveValueSeed = false;

  bool haveValuePrivate = false;

  bool seedField = false;

  bool privateField = false;

  ImportCubit() : super(ImportInitial());
  final BehaviorSubject<List<String>> _behaviorSubject =
      BehaviorSubject<List<String>>();
  final BehaviorSubject<String> _stringSubject =
      BehaviorSubject.seeded(S.current.seed_phrase);
  final BehaviorSubject<bool> _boolSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _seedSubject = BehaviorSubject<bool>();
  final BehaviorSubject<FormType> _formTypeSubject =
      BehaviorSubject.seeded(FormType.PASS_PHRASE);
  final BehaviorSubject<bool> _buttonSubject = BehaviorSubject<bool>();
  final BehaviorSubject<String> _txtWarningSeed =
      BehaviorSubject<String>.seeded('');
  ///
  Sink<String> get txtWarningSeedSink => _txtWarningSeed.sink;

  Stream<String> get txtWarningSeedStream => _txtWarningSeed.stream;

  ///
  Stream<bool> get seedStream => _seedSubject.stream;

  Sink<bool> get seedSink => _seedSubject.sink;

  bool get seedValue => _seedSubject.valueOrNull ?? false;

  /// button subject
  Stream<bool> get btnStream => _buttonSubject.stream;

  Sink<bool> get btnSink => _buttonSubject.sink;

  bool get btnValue => _buttonSubject.valueOrNull ?? false;

  Stream<List<String>> get listStringStream => _behaviorSubject.stream;

  Sink<List<String>> get listStringSink => _behaviorSubject.sink;

  String get strValue => _stringSubject.value;

  Stream<String> get stringStream => _stringSubject.stream;

  Sink<String> get stringSink => _stringSubject.sink;

  Stream<bool> get boolStream => _boolSubject.stream;

  Sink<bool> get boolSink => _boolSubject.sink;

  Stream<FormType> get typeStream => _formTypeSubject.stream;

  Sink<FormType> get typeSink => _formTypeSubject.sink;

  FormType get type => _formTypeSubject.value;

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

  bool isMatch(String value, String confirmValue) {
    if (Validator.validateStructure(value) && (value == confirmValue)) {
      return true;
    } else {
      return false;
    }
  }

  void checkSeedField(String value) {
    if (value.isNotEmpty) {
      haveValueSeed = true;
    } else {
      haveValueSeed = false;
    }
    if (haveValueSeed || haveValuePrivate) {
      btnSink.add(true);
    } else {
      btnSink.add(false);
    }
  }

  void checkPrivateField(String value) {
    if (value.isNotEmpty) {
      haveValuePrivate = true;
    } else {
      haveValuePrivate = false;
    }
    if (haveValuePrivate || haveValuePrivate) {
      btnSink.add(true);
    } else {
      btnSink.add(false);
    }
  }

  void showTxtWarningSeed(String value, FormType type) {
    if (type == FormType.PASS_PHRASE) {
      if (value.isEmpty) {
        seedField = false;
        seedSink.add(true);
        txtWarningSeedSink.add(S.current.seed_required);
        btnSink.add(false);
      } else {
        final int len = value.split(' ').length;
        if (len == 12 || len == 15 || len == 18 || len == 21 || len == 24) {
          seedSink.add(false);
          seedField = true;
        } else {
          seedField = false;
          seedSink.add(true);
          txtWarningSeedSink.add(S.current.warning_seed);
          btnSink.add(false);
        }
      }
    } else {
      if (value.isEmpty) {
        privateField = false;
        seedSink.add(true);
        txtWarningSeedSink.add(S.current.private_required);
        btnSink.add(false);
      } else {
        final int len = value.length;
        if (len == 64 && !value.contains(' ')) {
          privateField = true;
          seedSink.add(false);
        }
        else{
          privateField = false;
          seedSink.add(true);
          txtWarningSeedSink.add(S.current.private_warning);
          btnSink.add(false);
        }
      }
    }
  }

  bool validateAll() {
    if (seedField || privateField) {
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
    _txtWarningSeed.close();
    _seedSubject.close();
    super.close();
  }
}
