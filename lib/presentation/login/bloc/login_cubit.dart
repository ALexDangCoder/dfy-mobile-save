import 'dart:math';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  bool hidePass = true;

  bool hidePassword() {
    return hidePass = !hidePass;
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'checkPasswordCallback':
        break;

      default:
        break;
    }
  }

  Future<void> checkPasswordWallet(String password) async {
    try {
      final data = {
        'password': password,
      };
      await trustWalletChannel.invokeMethod('checkPassword', data);
    } on PlatformException {
      log(e);
    }
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
