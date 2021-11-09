import 'package:flutter/services.dart';

import '../../../main.dart';
class SendTokenBloc {
  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case "checkPasswordCallback":
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
      //todo
    }
  }
}
