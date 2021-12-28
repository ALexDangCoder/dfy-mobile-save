import 'dart:math';

import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/account_model.dart';
import 'package:Dfy/domain/model/private_key_model.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/utils/extensions/validator.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:rxdart/rxdart.dart';

part 'confirm_pw_prvkey_seedpharse_state.dart';

class ConfirmPwPrvKeySeedpharseCubit
    extends Cubit<ConfirmPwPrvKeySeedpharseState> {
  ConfirmPwPrvKeySeedpharseCubit()
      : super(ConfirmPwPrvKeySeedpharseInitial()) {}

  bool isValidPW = false;
  bool isFaceID = false;
  String authorized = 'Not Authorized';
  bool authenticated = false;
  final LocalAuthentication auth = LocalAuthentication();
  BehaviorSubject<List<AccountModel>> list = BehaviorSubject.seeded([]);
  final BehaviorSubject<bool> _isEnableButton =
      BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _isSuccessWhenScan =
      BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> _showValidatePW =
      BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<String> _txtWarningValidate =
      BehaviorSubject<String>.seeded('');
  final BehaviorSubject<bool> _showPW = BehaviorSubject<bool>.seeded(true);

  //stream
  Stream<bool> get isEnableBtnStream => _isEnableButton.stream;

  Stream<bool> get isSuccessWhenScanStream => _isSuccessWhenScan.stream;

  Stream<bool> get showPWStream => _showPW.stream;

  Stream<bool> get showValidatePWStream => _showValidatePW.stream;

  Stream<String> get txtWarningValidateStream => _txtWarningValidate.stream;

  //sink
  Sink<bool> get isEnableBtnSink => _isEnableButton.sink;

  Sink<bool> get isSuccessWhenScanSink => _isSuccessWhenScan.sink;

  Sink<bool> get showPWSink => _showPW.sink;

  Sink<bool> get showValidatePWSink => _showValidatePW.sink;

  Sink<String> get txtWarningValidateSink => _txtWarningValidate.sink;

  List<Wallet> listWalletCore = [];
  List<PrivateKeyModel> listWallet = [];
  BehaviorSubject<int> index = BehaviorSubject.seeded(0);
  BehaviorSubject<List<PrivateKeyModel>> listPrivateKey = BehaviorSubject();

  BehaviorSubject<PrivateKeyModel> privateKeySubject = BehaviorSubject();

  String passWord = '';

  void getListPrivateKeyAndSeedPhrase({
    required String password,
    required bool isFaceId,
  }) {
    for (final value in listWalletCore) {
      exportWallet(
        walletAddress: value.address ?? '',
        password: password,
        isFaceId: isFaceId,
      );
    }
  }

  int randomAvatar() {
    final Random rd = Random();

    return rd.nextInt(10);
  }

  void sendPrivateKey(int _index) {
    privateKeySubject.sink.add(listWallet[_index]);
  }

  List<String> stringToList(String seedPhrase) {
    final List<String> list = seedPhrase.split(' ');
    return list;
  }

  void isEnableButton({required String value, String? passwordConfirm}) {
    passWord = value;
    if (value.isNotEmpty) {
      isEnableBtnSink.add(true);
    } else {
      isEnableBtnSink.add(false);
    }
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getListWalletsCallback':
        final List<dynamic> data = methodCall.arguments;
        for (final element in data) {
          listWalletCore.add(Wallet.fromJson(element));
        }
        break;
      case 'exportWalletCallBack':
        final String walletAddress =
            await methodCall.arguments['walletAddress'];
        final String privateKey = await methodCall.arguments['privateKey'];
        final String passPhrase = await methodCall.arguments['passPhrase'];
        final PrivateKeyModel obj = PrivateKeyModel(
          seedPhrase: passPhrase,
          privateKey: privateKey,
          walletAddress: walletAddress,
        );
        listWallet.add(obj);
        break;
      case 'checkPasswordCallback':
        bool isCorrect = false;
        isCorrect = await methodCall.arguments['isCorrect'];
        if (isCorrect) {
          emit(ConfirmPWToShowSuccess());
        } else {
          emit(ConfirmPWToShowFail());
        }
        break;
      default:
        break;
    }
  }

  void scanFaceIdFinger({required bool value}) {
    if (value) {
      emit(ConfirmPWToShowSuccess());
    } else {}
  }

  Future<void> getListWallets() async {
    try {
      final data = {};
      await trustWalletChannel.invokeMethod('getListWallets', data);
    } on PlatformException {
      //nothing
    }
  }

//exportWallet
  Future<void> exportWallet({
    required String walletAddress,
    required String password,
    required bool isFaceId,
  }) async {
    try {
      final data = {
        'password': password,
        'walletAddress': walletAddress,
        'isFaceId': isFaceId,
      };
      await trustWalletChannel.invokeMethod('exportWallet', data);
    } on PlatformException {
      //todo

    }
  }

  Future<void> checkPassword({required String password}) async {
    try {
      final data = {
        'password': password,
      };
      await trustWalletChannel.invokeMethod('checkPassword', data);
    } on PlatformException {
      //todo
    }
  }

  Future<void> authenticate() async {
    isSuccessWhenScanSink.add(false);
    authenticated = await auth.authenticate(
      localizedReason:
          'Scan your fingerprint (or face or whatever) to authenticate',
      stickyAuth: true,
      biometricOnly: true,
    );
    if (authenticated == true) {
      isSuccessWhenScanSink.add(true);
    }
  }

  void getConfig() {
    if (PrefsService.getFaceIDConfig() == 'true') {
      isFaceID = true;
    } else {
      isFaceID = false;
    }
  }

  void checkValidate(
    String value,
  ) {
    if ((value.isNotEmpty && value.length < 8) ||
        (value.isNotEmpty && value.length > 15)) {
      isValidPW = false;
      showValidatePWSink.add(true);
      txtWarningValidateSink.add(S.current.warn_pw_8_15);
    } else if (value.isEmpty) {
      isValidPW = false;
      showValidatePWSink.add(true);
      txtWarningValidateSink.add(S.current.password_is_required);
    } else if (!Validator.validateStructure(value)) {
      isValidPW = false;
      showValidatePWSink.add(true);
      txtWarningValidateSink.add(S.current.warn_pw_validate);
    }
    // else if (value != rightPW) {
    //   isValidPW = false;
    //   showValidatePWSink.add(true);
    //   txtWarningValidateSink.add(S.current.not_match);
    // }
    else {
      isValidPW = true;
      showValidatePWSink.add(false);
    }
  }

  void showPW(int index) {
    if (index == 0) {
      showPWSink.add(true);
    } else {
      showPWSink.add(false);
    }
  }
}
//warfare pluck security velvet finish enroll frost flock suffer anchor view seek
