import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  bool hidePass = true;
  bool isAppLock = true;
  bool isFaceID = false;
  String signature = '';
  String walletAddress = '';
  int nonce = 0;
  BehaviorSubject<bool> isFaceIDStream = BehaviorSubject();

  BehaviorSubject<bool> isLoginSuccessSubject = BehaviorSubject();

  BehaviorSubject<bool> isSaveInfoSuccessSubject = BehaviorSubject();

  BehaviorSubject<String> signatureSubject = BehaviorSubject();

  Stream<bool> get isLoginSuccessStream => isLoginSuccessSubject.stream;

  Stream<bool> get isSaveInfoSuccessStream => isSaveInfoSuccessSubject.stream;

  Stream<String> get signatureStream => signatureSubject.stream;

  bool hidePassword() {
    return hidePass = !hidePass;
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    emit(LoginLoading());
    bool loginSuccess = false;
    switch (methodCall.method) {
      case 'checkPasswordCallback':
        loginSuccess = await methodCall.arguments['isCorrect'];
        if (loginSuccess == true) {
          emit(LoginPasswordSuccess());
        } else {
          emit(LoginPasswordError());
        }
        break;
      case 'getConfigCallback':
        isAppLock = await methodCall.arguments['isAppLock'];
        isFaceID = await methodCall.arguments['isFaceID'];
        isFaceIDStream.add(isFaceID);
        break;
      case 'getListWalletsCallback':
        walletAddress = (methodCall.arguments as List)
            .first['walletAddress'];
        break;
      case 'signWalletCallback':
        signature = await methodCall.arguments['signature'];
        signatureSubject.sink.add(signature);
        break;
      default:
        break;
    }
  }

  Future<void> getConfig() async {
    try {
      final data = {};
      await trustWalletChannel.invokeMethod('getConfig', data);
    } on PlatformException {
      //nothing
    }
  }

  Future<void> checkPasswordWallet(String password) async {
    emit(LoginLoading());
    try {
      final data = {
        'password': password,
      };
      await trustWalletChannel.invokeMethod('checkPassword', data);
    } on PlatformException {
      //nothing
    }
  }

  String authorized = 'Not Authorized';
  bool authenticated = false;
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> checkBiometrics() async {
    final bool canCheckBiometrics = await auth.canCheckBiometrics;
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    if (canCheckBiometrics && isFaceIDStream.value) {
      await authenticate();
    }
  }

  Future<void> authenticate() async {
    emit(LoginLoading());
    authenticated = await auth.authenticate(
      localizedReason:
          'Scan your fingerprint (or face or whatever) to authenticate',
      stickyAuth: true,
      biometricOnly: true,
    );
    if (authenticated == true) {
      emit(LoginSuccess());
    }
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
