import 'package:Dfy/config/resources/strings.dart';
import 'package:Dfy/presentation/create_wallet_first_time/setup_password/helper/validator.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import '../../../main.dart';

class ImportTokenNftBloc {
  BehaviorSubject<String> tokenAddressText = BehaviorSubject.seeded('');

  BehaviorSubject<String> tokenDecimal = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenSymbol = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenAddressTextNft = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenSymbolText = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenDecimalText = BehaviorSubject.seeded('');

  // void formatAddress() {
  //   tokenAddressText.stream.listen((event) {
  //     final splitAddress = event.split('');
  //     tokenAddressText1.sink.add('${splitAddress[0]}'
  //         '${splitAddress[1]}${splitAddress[2]}'
  //         '${splitAddress[3]}${splitAddress[6]}'
  //         '${splitAddress[5]}...${splitAddress[37]}'
  //         '${splitAddress[38]}${splitAddress[39]}'
  //         '${splitAddress[40]}');
  //   });
  // }
  //

  Future<void> importToken({
    String password = '',
    required String walletAddress,
    required String tokenAddress,
    required String symbol,
    required int decimal,
  }) async {
    try {
      final data = {
        'password': password,
        'walletAddress': walletAddress,
        'tokenAddress': tokenAddress,
        'symbol': symbol,
        'decimal': decimal,
      };
      await trustWalletChannel.invokeMethod('importToken', data);
    } on PlatformException {
      //todo

    }
  }

  Future<void> getListSupportedToken({
    String password = '',
    required String walletAddress,
  }) async {
    try {
      final data = {
        'password': password,
        'walletAddress': walletAddress,
      };
      await trustWalletChannel.invokeMethod('getListSupportedToken', data);
    } on PlatformException {
      //todo

    }
  }

  Future<void> setShowedToken({
    String password = '',
    required String walletAddress,
    required int tokenID,
    required bool isShow,
  }) async {
    try {
      final data = {
        'password': password,
        'walletAddress': walletAddress,
        'tokenID': tokenID,
        'isShow': isShow,
      };
      await trustWalletChannel.invokeMethod('setShowedToken', data);
    } on PlatformException {
      //todo

    }
  }

  Future<void> importNft({
    String password = '',
    required String walletAddress,
    required String nftAddress,
    required int nftID,
  }) async {
    try {
      final data = {
        'password': password,
        'walletAddress': walletAddress,
        'nftAddress': nftAddress,
        'nftID': nftID,
      };
      await trustWalletChannel.invokeMethod('importNft', data);
    } on PlatformException {
      //todo

    }
  }

  Future<void> setShowedNft({
    String password = '',
    required String walletAddress,
    required int nftID,
    required bool isShow,
  }) async {
    try {
      final data = {
        'password': password,
        'walletAddress': walletAddress,
        'isShow': isShow,
        'nftID': nftID,
      };
      await trustWalletChannel.invokeMethod('setShowedNft', data);
    } on PlatformException {
      //todo

    }
  }

  bool isImportToken() {
    if (Validator.validateNotNull(tokenAddressText.value) &&
        Validator.validateNotNull(tokenDecimal.value) &&
        Validator.validateNotNull(tokenSymbol.value)) {
      return true;
    }
    return false;
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    final bool isImportToken;
    final bool isSetShowedToken;
    final bool isImportNft;
    final bool isSetShowedNft;

    switch (methodCall.method) {
      case 'importTokenCallback':
        isImportToken = await methodCall.arguments['isSuccess'];

        break;
      case 'getListSupportedTokenCallback':
        //[TokenObject]
        var a = await methodCall.arguments['TokenObject'];

        break;
      case 'setShowedTokenCallback':
        isSetShowedToken = await methodCall.arguments['isSuccess'];


        break;
      case 'importNftCallback':


        isImportNft = await methodCall.arguments['isSuccess'];


        break;
      case 'setShowedNftCallback':

        isSetShowedNft = await methodCall.arguments['isSuccess'];


        break;
      default:
        break;
    }
  }
}
