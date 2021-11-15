import 'package:Dfy/domain/model/token.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import '../../../main.dart';

class ImportTokenNftBloc {
  ImportTokenNftBloc() {
    getListSort();
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

  BehaviorSubject<bool> isNFT = BehaviorSubject.seeded(true);

  BehaviorSubject<List<TokenModel>> getList = BehaviorSubject.seeded([]);

  String formatNumber(double amount) {
    return '${amount.toStringAsExponential(5).toString().substring(0, 5)}'
        ',${amount.toStringAsExponential(5).toString().substring(5, 7)}';
  }

  void checkAddressNull2() {
    if (tokenAddressTextNft.value == '') {
      isNFT.sink.add(false);
    } else {
      isNFT.sink.add(true);
    }
  }

  void getListSort() {
    final List<TokenModel> list = [];
    for (final TokenModel value in listToken) {
      if (value.isShow ?? false) {
        list.add(value);
      }
    }
    final Comparator<TokenModel> amountTokenComparator =
        (b, a) => (a.amountToken ?? 0).compareTo(b.amountToken ?? 0);
    list.sort(amountTokenComparator);
    final List<TokenModel> list1 = [];
    for (final TokenModel value in listToken) {
      if (value.isShow ?? false) {
      } else {
        if ((value.amountToken ?? 0) > 0) {
          list1.add(value);
        }
      }
    }
    list1.sort(amountTokenComparator);
    list.addAll(list1);
    for (final TokenModel value in listToken) {
      if (value.isShow ?? false) {
      } else {
        if ((value.amountToken ?? 0) > 0) {
        } else {
          list.add(value);
        }
      }
    }
    getList.sink.add(list);
  }

  void search() {
    final List<TokenModel> list = [];
    for (final TokenModel value in listToken) {
      if (value.nameToken!.toLowerCase().contains(
            textSearch.value.toLowerCase(),
          )) {
        list.add(value);
      }
    }
    if (textSearch.value == '') {
      getListSort();
    } else {
      getList.sink.add(list);
    }
  }

  List<TokenModel> listToken = [
    TokenModel(
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'TBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 0,
    ),
    TokenModel(
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'TBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 0,
    ),
    TokenModel(
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'TBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 1,
    ),
    TokenModel(
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'Bitcoin',
      nameTokenSymbol: 'BTC',
      amountToken: 0.2134,
    ),
    TokenModel(
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: true,
      nameToken: 'ABitcoin',
      nameTokenSymbol: 'BTC',
      amountToken: 0.324,
    ),
    TokenModel(
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'CBitcoin',
      nameTokenSymbol: 'BTC',
      amountToken: 2.21321434,
    ),
    TokenModel(
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: true,
      nameToken: 'DBitcoin',
      nameTokenSymbol: 'BTC',
      amountToken: 0,
    ),
    TokenModel(
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: true,
      nameToken: 'WBitcoin',
      nameTokenSymbol: 'BTC3',
      amountToken: 021342342134.21312344,
    ),
    TokenModel(
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'QBitcoin',
      nameTokenSymbol: 'BT3C',
      amountToken: 0,
    ),
    TokenModel(
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: true,
      nameToken: 'UBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 0.213434,
    ),
    TokenModel(
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'TBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 0.423213423,
    ),
    TokenModel(
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'TBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 0,
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
        final a = await methodCall.arguments['TokenObject'];

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
