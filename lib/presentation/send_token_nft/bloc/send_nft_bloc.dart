import 'package:flutter/services.dart';

import '../../../main.dart';

class SendNftBloc {
  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case "checkPasswordCallback":
        break;

      default:
        break;
    }
  }

  Future<void> sendNftWallet(
      {required String walletAddress,
      required String receiveAddress,
      required int nftID,
      String? password}) async {
    try {
      final data = {
        'password': password,
      };
      await trustWalletChannel.invokeMethod('sendNft', data);
    } on PlatformException {
      //todo
    }
  }
}
