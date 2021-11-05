import 'package:Dfy/config/resources/strings.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import '../../../main.dart';

class ImportTokenNftBloc {
  BehaviorSubject<String> tokenAddressText = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenAddressText1 = BehaviorSubject.seeded('');

  ImportTokenNftBloc();

  void formatAddress() {
    tokenAddressText.stream.listen((event) {
      final splitAddress = event.split('');
      tokenAddressText1.sink.add('${splitAddress[0]}'
          '${splitAddress[1]}${splitAddress[2]}'
          '${splitAddress[3]}${splitAddress[6]}'
          '${splitAddress[5]}...${splitAddress[37]}'
          '${splitAddress[38]}${splitAddress[39]}'
          '${splitAddress[40]}');
    });
  }

  BehaviorSubject<String> tokenAddressNFTText = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenAddressNFTText2 = BehaviorSubject.seeded('');

  void formatAddress2() {
    tokenAddressNFTText.stream.listen((event) {
      final splitAddress = event.split('');
      tokenAddressNFTText2.sink.add('${splitAddress[0]}'
          '${splitAddress[1]}${splitAddress[2]}'
          '${splitAddress[3]}${splitAddress[6]}'
          '${splitAddress[5]}...${splitAddress[37]}'
          '${splitAddress[38]}${splitAddress[39]}'
          '${splitAddress[40]}');
    });
  }

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
      await trustWalletChannel.invokeMethod('importTokenCallback', data);
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
      await trustWalletChannel.invokeMethod(
          'getListSupportedTokenCallback', data);
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
      await trustWalletChannel.invokeMethod('setShowedTokenCallback', data);
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
      await trustWalletChannel.invokeMethod('importNftCallback', data);
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
      await trustWalletChannel.invokeMethod('setShowedNftCallback', data);
    } on PlatformException {
      //todo

    }
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    bool isImportToken;
    bool isGetListSupportedToken;
    bool isSetShowedToken;
    bool isImportNft;
    bool isSetShowedNft;

    switch (methodCall.method) {
      case 'importTokenCallback':
        isImportToken = methodCall.arguments['importToken'];
        print(isImportToken);
        break;
      case 'getListSupportedTokenCallback':
        //[TokenObject]
        break;
      case 'setShowedTokenCallback':
        isImportToken = methodCall.arguments['setShowedToken'];
        print(isImportToken);

        break;
      case 'importNftCallback':
        isImportToken = methodCall.arguments['importNft'];
        print(isImportToken);

        break;
      case 'setShowedNftCallback':
        isImportToken = methodCall.arguments['setShowedNft'];
        print(isImportToken);

        break;
      default:
        break;
    }
  }
}
