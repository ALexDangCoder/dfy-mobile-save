import 'dart:math';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  bool hidePass = true;
  bool isAppLock = true;
  bool isFaceID = false;

  bool hidePassword() {
    return hidePass = !hidePass;
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    emit(LoginLoading());
    bool loginSuccess = false;

    switch (methodCall.method) {
      case 'checkPasswordCallback':
        loginSuccess = methodCall.arguments['isCorrect'];
        break;
      default:
        break;
    }

    if (loginSuccess == true) {
      emit(LoginSuccess());
    } else {
      emit(LoginError('Password was wrong...'));
    }
  }

  void getConfig() {
    if (PrefsService.getAppLockConfig() == 'true') {
      isAppLock = true;
    } else {
      isAppLock = false;
    }
    if (PrefsService.getFaceIDConfig() == 'true') {
      isFaceID = true;
    } else {
      isFaceID = false;
    }
  }

  Future<void> checkPasswordWallet(String password) async {
    emit(LoginLoading());
    try {
      final data = {
        'password': password,
      };
      await trustWalletChannel.invokeMethod('checkPassword', data);
    } on PlatformException {}
  }

  String authorized = 'Not Authorized';
  bool authenticated = false;
  final LocalAuthentication auth = LocalAuthentication();

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
  }
}
