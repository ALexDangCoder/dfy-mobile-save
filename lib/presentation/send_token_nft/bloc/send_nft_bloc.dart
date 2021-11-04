import 'package:flutter/services.dart';

import '../../../main.dart';

class SendNftBloc {
  String walletAddress = '';
  String receiveAddress = '';
  int? nftID;
  String password = '';

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case "checkPasswordCallback":
        walletAddress = await methodCall.arguments['walletAddress'];
        receiveAddress = await methodCall.arguments['receiveAddress'];
        password = await methodCall.arguments['password'];
        nftID = await methodCall.arguments['nftID'];
        break;

      default:
        break;
    }
  }

  Future<void> sendNftWallet({
    required String walletAddress,
    required String receiveAddress,
    required int nftID,
    String? password,
  }) async {
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
