import 'package:Dfy/config/resources/strings.dart';
import 'package:Dfy/domain/model/token.dart';
import 'package:Dfy/presentation/create_wallet_first_time/setup_password/helper/validator.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:rxdart/rxdart.dart';

import '../../../main.dart';

class ImportTokenNftBloc {
  ImportTokenNftBloc() {
    getList.sink.add(listToken);
  }

  BehaviorSubject<String> tokenAddressText = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenDecimal = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenSymbol = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenAddressTextNft = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenSymbolText = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenDecimalText = BehaviorSubject.seeded('');
  BehaviorSubject<bool> isTokenAddressText = BehaviorSubject.seeded(true);

  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');

  BehaviorSubject<bool> isTokenEnterAddress = BehaviorSubject.seeded(false);

  BehaviorSubject<bool> isNFT = BehaviorSubject.seeded(false);

  BehaviorSubject<List<TokenModel>> getList = BehaviorSubject.seeded([]);

  void getShare() {
    List<TokenModel> list = [];
    for (TokenModel value in listToken) {
      if (value.nameToken!.toLowerCase().contains(
            textSearch.value.toLowerCase(),
          )) {
        list.add(value);
      }
    }
    getList.sink.add(list);
  }

  List<TokenModel> listToken = [
    TokenModel(
      tokenId:21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'Bitcoin',
      nameTokenSymbol: 'BTC',
      amountToken: 0.2134,
    ),
    TokenModel(
      tokenId:21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'ABitcoin',
      nameTokenSymbol: 'BTC',
      amountToken: 0.324,
    ),
    TokenModel(
      tokenId:21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'CBitcoin',
      nameTokenSymbol: 'BTC',
      amountToken: 0.21321434,
    ),
    TokenModel(
      tokenId:21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'DBitcoin',
      nameTokenSymbol: 'BTC',
      amountToken: 0.21213434,
    ),
    TokenModel(
      tokenId:21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'WBitcoin',
      nameTokenSymbol: 'BTC3',
      amountToken: 0.21312344,
    ),
    TokenModel(
      tokenId:21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'QBitcoin',
      nameTokenSymbol: 'BT3C',
      amountToken: 0.32143214,
    ),
    TokenModel(
      tokenId:21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'UBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 0.213434,
    ),
    TokenModel(
      tokenId:21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'TBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 0.423213423,
    ),
  ];

  void checkAddressNull() {
    if (tokenAddressText.value == '') {
      isTokenAddressText.sink.add(false);
    } else {
      isTokenAddressText.sink.add(true);
    }
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
