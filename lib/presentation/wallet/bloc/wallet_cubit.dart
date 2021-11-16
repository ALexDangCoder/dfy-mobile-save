import 'dart:math';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/model/account_model.dart';
import 'package:Dfy/domain/model/token.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/utils/extensions/validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';


part 'wallet_state.dart';

class WalletCubit extends BaseCubit<WalletState> {
  WalletCubit() : super(WalletInitial()) {
    listTokenDetailScreen = listTokenInitial;
    getListSort();
    getList();
    getListTokenItem();
    getListNFTItem();
  }
  bool checkLogin = false;
  List<TokenModel> listStart = [];

  BehaviorSubject<List<TokenModel>> listTokenStream =
      BehaviorSubject.seeded([]);
  BehaviorSubject<List<TokenModel>> listNFTStream = BehaviorSubject.seeded([]);
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
  BehaviorSubject<List<TokenModel>> getListTokenModel =
      BehaviorSubject.seeded([]);
  BehaviorSubject<List<AccountModel>> list = BehaviorSubject.seeded([]);
  BehaviorSubject<String> addressWallet =
      BehaviorSubject.seeded('0xe77c14cdF13885E1909149B6D9B65734aefDEAEf');
  BehaviorSubject<String> walletName = BehaviorSubject.seeded('Account 1');
  BehaviorSubject<bool> isWalletName = BehaviorSubject.seeded(true);
  BehaviorSubject<double> totalBalance = BehaviorSubject();

  void getIsWalletName(String value) {
    if (Validator.validateNotNull(value)) {
      isWalletName.sink.add(true);
    } else {
      isWalletName.sink.add(false);
    }
  }

  String addressWalletCore = '';

  void addToken(TokenModel tokenModel) {
    listTokenDetailScreen.add(tokenModel);
    listTokenStream.sink.add(listTokenDetailScreen);
  }

  Future<void> getAddressWallet() async {}

  String formatAddress(String address) {
    if(address.isEmpty) return address;
    final String formatAddressWallet =
        '${address.substring(0, 5)}...${address.substring(
      address.length - 4,
      address.length,
    )}';
    return formatAddressWallet;
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    Object objToken = {};
    Object objNFT = {};
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
      case 'getListShowedTokenCallback':
        objToken = methodCall.arguments['TokenObject'];
        break;
      case 'getListShowedNftCallback':
        objNFT = methodCall.arguments;
        break;
      default:
        break;
    }
  }

  Future<void> getListToken(String walletAddress, String password) async {
    try {
      final data = {
        'walletAddress': walletAddress,
        'password': password,
      };
      await trustWalletChannel.invokeMethod('getListShowedToken', data);
    } on PlatformException {
      log(e);
    }
  }

// list
  Future<void> getListNFT(
    String walletAddress, {
    required String password,
  }) async {
    try {
      final data = {
        'walletAddress': walletAddress,
        'password': password,
      };
      await trustWalletChannel.invokeMethod('getListShowedNft', data);
    } on PlatformException {
      log(e);
    }
  }

  void getListTokenItem() {
    final List<TokenModel> list = [];
    for (final TokenModel value in getListTokenModel.value) {
      if (value.isShow ?? false) {
        list.add(value);
      }
    }
    listTokenDetailScreen.clear();
    listTokenDetailScreen.addAll(list);
    listTokenStream.sink.add(listTokenDetailScreen);
  }

  double total(List<TokenModel> list) {
    double total = 0;
    for (int i = 0; i < list.length; i++) {
      total = total + list[i].price!;
    }
    return total;
  }

  void getListTokenItemRemove() {
    listTokenStream.sink.add(listTokenDetailScreen);
  }

  void getList() {
    list.sink.add(listSelectAccBloc);
  }

  List<AccountModel> listSelectAccBloc = [
    AccountModel(
      isCheck: true,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: false,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: false,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: false,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: false,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: false,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
  ];

  void click(int index) {
    for (final AccountModel value in listSelectAccBloc) {
      value.isCheck = false;
    }
    listSelectAccBloc[index].isCheck = true;
    list.sink.add(listSelectAccBloc);
  }

  void getListNFTItem() {
    listNFTStream.sink.add(listNFT);
  }

  List<TokenModel> listNFT = [
    TokenModel(
      nameToken: 'DEFI FOR YOU2',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR 3YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR 3YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR 3YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR 3YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR2 YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR 34YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR453 YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR23452345 YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
  ];

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
    for (final TokenModel value in listTokenInitial) {
      if (value.isShow ?? false) {
        list.add(value);
      }
    }
    final Comparator<TokenModel> amountTokenComparator =
        (b, a) => (a.amountToken ?? 0).compareTo(b.amountToken ?? 0);
    list.sort(amountTokenComparator);
    final List<TokenModel> list1 = [];
    for (final TokenModel value in listTokenInitial) {
      if (value.isShow ?? false) {
      } else {
        if ((value.amountToken ?? 0) > 0) {
          list1.add(value);
        }
      }
    }
    list1.sort(amountTokenComparator);
    list.addAll(list1);
    for (final TokenModel value in listTokenInitial) {
      if (value.isShow ?? false) {
      } else {
        if ((value.amountToken ?? 0) > 0) {
        } else {
          list.add(value);
        }
      }
    }
    listStart.addAll(list);

    getListTokenModel.sink.add(list);
  }

  void search() {
    final List<TokenModel> result = [];
    // listTokenShow1=listToken;
    for (final TokenModel value in listTokenInitial) {
      if (value.nameToken!.toLowerCase().contains(
            textSearch.value.toLowerCase(),
          )) {
        result.add(value);
      }
    }
    if (textSearch.value.isEmpty) {
      getListTokenModel.sink.add(listStart);
    }
    if (textSearch.value.isNotEmpty) {
      getListTokenModel.sink.add(result);
    }
  }

  List<TokenModel> listTokenDetailScreen = [];
  List<TokenModel> listTokenInitial = [
    TokenModel(
      price: 342.423,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'TBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 0,
    ),
    TokenModel(
      price: 3421.2223,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'TBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 0,
    ),
    TokenModel(
      price: 34213423,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'TBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 1,
    ),
    TokenModel(
      price: 121,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'Bitcoin',
      nameTokenSymbol: 'BTC',
      amountToken: 0.2134,
    ),
    TokenModel(
      price: 121,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: true,
      nameToken: 'ABitcoin',
      nameTokenSymbol: 'BTC',
      amountToken: 0.324,
    ),
    TokenModel(
      price: 121,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'CBitcoin',
      nameTokenSymbol: 'BTC',
      amountToken: 2.21321434,
    ),
    TokenModel(
      price: 121,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: true,
      nameToken: 'DBitcoin',
      nameTokenSymbol: 'BTC',
      amountToken: 0,
    ),
    TokenModel(
      price: 121,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: true,
      nameToken: 'WBitcoin',
      nameTokenSymbol: 'BTC3',
      amountToken: 021342344,
    ),
    TokenModel(
      price: 121,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'QBitcoin',
      nameTokenSymbol: 'BT3C',
      amountToken: 0,
    ),
    TokenModel(
      price: 121,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: true,
      nameToken: 'UBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 0.213434,
    ),
    TokenModel(
      price: 121,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'TBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 0.413423,
    ),
    TokenModel(
      price: 121,
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
}
